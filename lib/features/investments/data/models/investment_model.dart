import 'package:flutter/material.dart';

class InvestmentModel {
  final String name;
  final String ticker;
  final double value;
  final double changePercent;
  final Color color;

  const InvestmentModel({
    required this.name,
    required this.ticker,
    required this.value,
    required this.changePercent,
    required this.color,
  });

  bool get isPositive => changePercent >= 0;
}
