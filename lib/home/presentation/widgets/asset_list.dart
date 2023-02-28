import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:portfolio_statistics/home/data/holdings_asset.dart';
import 'package:portfolio_statistics/extensions/format_currency.dart';
import 'package:portfolio_statistics/home/state/portfolio_cubit.dart';

class AssetList extends StatelessWidget {
  const AssetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final holdings = context.read<PortfolioCubit>().state.holdings;
    final totalValue = context.read<PortfolioCubit>().state.totalAssetsValue;
    final selectedFilter = context.watch<PortfolioCubit>().state.selectedFilter;

    final filteredHoldings = selectedFilter != 'Asset Type'
        ? (holdings?.where((e) => e.type == selectedFilter) as Iterable<HoldingsAsset>)
        : holdings;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Expanded(
                  child: Text('Name'),
                ),
                Expanded(
                  child: Text('Ticker'),
                ),
                Expanded(
                  flex: 2,
                  child: Text('Percentage (%)'),
                ),
                Expanded(
                  child: Text('Amount (\$)'),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredHoldings?.length ?? 0,
            itemBuilder: (context, index) {
              final asset = filteredHoldings?.elementAt(index);
              final percentage = ((asset?.value ?? 0) / totalValue) * 100;
              final rowColor = index % 2 == 0 ? Colors.grey[200] : Colors.transparent;

              return Container(
                color: rowColor,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        asset?.name ?? '',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        asset?.ticker ?? '',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        percentage.toStringAsFixed(2) + '%',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        (asset?.value ?? 0).formatCurrency,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
