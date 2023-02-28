import 'package:intl/intl.dart' show NumberFormat;

extension FormatCurrency on int {
  String get formatCurrency {
    final currencyFormatter = NumberFormat.simpleCurrency(decimalDigits: 0);
    return currencyFormatter.format(this);
  }
}
