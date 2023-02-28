// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show immutable, setEquals;

import 'package:portfolio_statistics/home/data/repository.dart';
import 'package:portfolio_statistics/home/data/holdings_asset.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit(this.repository) : super(PortfolioState.initial());

  final PortfolioRepository repository;

  void fetchPortfolioByUserId(String userId) async {
    emit(
      state.copyWith(
        status: PortfolioStatus.loading,
      ),
    );

    final holdings = await repository.fetchHoldings(userId);

    final filterMenu = {
      'Asset Type',
      for (final asset in holdings) asset.type,
    };

    emit(
      state.copyWith(
        status: PortfolioStatus.success,
        holdings: holdings,
        filterMenu: filterMenu,
        selectedFilter: 'Asset Type', // Selecting as Default
      ),
    );
  }

  void handleFilterChange(String assetName) {
    emit(
      state.copyWith(
        status: PortfolioStatus.success,
        selectedFilter: assetName,
      ),
    );
  }
}
