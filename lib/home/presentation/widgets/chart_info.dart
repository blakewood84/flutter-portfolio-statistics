import 'package:flutter/material.dart';

import 'package:portfolio_statistics/home/presentation/widgets/pie_chart.dart';
import 'package:portfolio_statistics/home/presentation/widgets/asset_list.dart';
import 'package:portfolio_statistics/home/presentation/widgets/asset_dropdown.dart';

class ChartAndInfo extends StatelessWidget {
  const ChartAndInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Portfolio Chart',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20.0),
        // Assets Chart
        const PieChartWidget(),
        const SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Portfolio Holdings',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            // Dropdown to search by assets. Is defaulted to ALL
            AssetDropdown(),
          ],
        ),
        const SizedBox(height: 10.0),
        // A List of Assets that is responsive to the AssetDropdown widget
        const AssetList(),
      ],
    );
  }
}
