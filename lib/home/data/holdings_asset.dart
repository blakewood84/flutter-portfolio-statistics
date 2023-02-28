import 'package:flutter/material.dart' show immutable;

@immutable
class HoldingsAsset {
  const HoldingsAsset({
    required this.ticker,
    required this.name,
    required this.type,
    required this.value,
  });

  final String ticker;
  final String name;
  final String type;
  final int value;

  factory HoldingsAsset.fromJson(dynamic json) => HoldingsAsset(
        ticker: json['ticker'] ?? '',
        name: json['name'] ?? '',
        type: json['type'] ?? '',
        value: json['value'] ?? 0,
      );

  @override
  bool operator ==(covariant HoldingsAsset other) {
    if (identical(this, other)) return true;

    return other.ticker == ticker && other.name == name && other.type == type && other.value == value;
  }

  @override
  int get hashCode {
    return ticker.hashCode ^ name.hashCode ^ type.hashCode ^ value.hashCode;
  }

  @override
  String toString() {
    return 'HoldingsAsset(ticker: $ticker, name: $name, type: $type, value: $value)';
  }
}
