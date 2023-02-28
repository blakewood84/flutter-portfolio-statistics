import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:portfolio_statistics/constants/constants.dart';
import 'package:portfolio_statistics/extensions/format_key.dart';
import 'package:portfolio_statistics/extensions/format_currency.dart';
import 'package:portfolio_statistics/home/state/portfolio_cubit.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final holdings = context.read<PortfolioCubit>().state.holdings ?? const Iterable.empty();
    final totalValue = context.read<PortfolioCubit>().state.totalAssetsValue;

    final holdingsByType = {
      for (final holding in holdings)
        holding.type: holdings.where(
          (e) => e.type == holding.type,
        ),
    };

    // Sort pie chart for ordering
    final sortedHoldingEntries = holdingsByType.entries.toList()
      ..sort((a, b) {
        final aTotal = a.value.fold(0, (int previousValue, element) => element.value + previousValue);
        final bTotal = b.value.fold(0, (int previousValue, element) => element.value + previousValue);

        return bTotal.compareTo(aTotal);
      });

    // Create Pie Chart sections
    final pieChartSections = sortedHoldingEntries.map(
      (e) {
        final total = e.value.fold(0, (int previousValue, element) => element.value + previousValue);
        final index = holdingsByType.keys.toList().indexOf(e.key);

        return PieChartSectionData(
          value: total.toDouble(),
          title: '',
          titleStyle: const TextStyle(
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
          color: pieColors[index],
        );
      },
    );

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              SizedBox(
                height: 200,
                width: 250,
                child: PieChart(
                  PieChartData(
                    sections: [
                      ...pieChartSections,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                totalValue.formatCurrency,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final entry in sortedHoldingEntries)
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: pieColors[holdingsByType.keys.toList().indexOf(entry.key)],
                      ),
                      const SizedBox(width: 10),
                      Text(
                        entry.key.formatKey,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
