import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:portfolio_statistics/home/data/repository.dart';
import 'package:portfolio_statistics/home/state/portfolio_cubit.dart';
import 'package:portfolio_statistics/common_widgets/textformfield.dart';
import 'package:portfolio_statistics/home/presentation/widgets/chart_info.dart';
import 'package:portfolio_statistics/home/presentation/widgets/loading_indicator.dart';

class PortfolioTrackerScreen extends StatelessWidget {
  const PortfolioTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => PortfolioCubit(
        PortfolioRepository(),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'AssetDash Portfolio Tracker',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(bottom: 10.0),
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                Builder(
                  builder: (context) {
                    return SizedBox(
                      width: 200,
                      child: FormFieldWidget(
                        initialValue: '',
                        hintText: 'Search by User ID',
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            context.read<PortfolioCubit>().fetchPortfolioByUserId(value);
                          }
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                BlocBuilder<PortfolioCubit, PortfolioState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case PortfolioStatus.initial:
                        {
                          return const SizedBox.shrink();
                        }

                      case PortfolioStatus.loading:
                        {
                          return const LoadingIndicator();
                        }

                      case PortfolioStatus.error:
                        {
                          return const SizedBox.shrink();
                        }

                      case PortfolioStatus.success:
                        {
                          return const ChartAndInfo();
                        }

                      default:
                        {
                          return const SizedBox.shrink();
                        }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
