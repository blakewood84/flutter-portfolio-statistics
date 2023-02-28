part of 'portfolio_cubit.dart';

enum PortfolioStatus {
  initial,
  loading,
  error,
  success,
}

@immutable
class PortfolioState {
  const PortfolioState({
    required this.status,
    this.holdings,
    this.filterMenu,
    this.selectedFilter,
  });

  final PortfolioStatus status;
  final Iterable<HoldingsAsset>? holdings;
  final Set<String>? filterMenu;
  final String? selectedFilter;

  int get totalAssetsValue => holdings?.fold(0, (previousValue, element) => (previousValue ?? 0) + element.value) ?? 0;

  factory PortfolioState.initial() => const PortfolioState(
        status: PortfolioStatus.initial,
      );

  PortfolioState copyWith({
    required PortfolioStatus status,
    Iterable<HoldingsAsset>? holdings,
    Set<String>? filterMenu,
    String? selectedFilter,
  }) =>
      PortfolioState(
        status: status,
        holdings: holdings ?? this.holdings,
        filterMenu: filterMenu ?? this.filterMenu,
        selectedFilter: selectedFilter ?? this.selectedFilter,
      );

  @override
  bool operator ==(covariant PortfolioState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.holdings == holdings &&
        setEquals(other.filterMenu, filterMenu) &&
        other.selectedFilter == selectedFilter;
  }

  @override
  int get hashCode {
    return status.hashCode ^ holdings.hashCode ^ filterMenu.hashCode ^ selectedFilter.hashCode;
  }
}
