import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'package:portfolio_statistics/home/data/holdings_asset.dart';

@immutable
class PortfolioRepository {
  final dio = Dio();
  Future<Iterable<HoldingsAsset>> fetchHoldings(String userId) async {
    final response = (await dio.get(
      'https://624760d3229b222a3fcc6155.mockapi.io/api/v1/portfolio/$userId',
    ))
        .data['holdings'] as List<dynamic>;

    final holdings = response.map((e) => HoldingsAsset.fromJson(e));
    return holdings;
  }
}
