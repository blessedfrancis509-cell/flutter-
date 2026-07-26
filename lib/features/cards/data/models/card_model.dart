import 'package:flutter/material.dart';

class BankCardModel {
  final String holderName;
  final String maskedNumber;
  final String expiry;
  final String type; // e.g. "Debit" or "Virtual"
  final List<Color> gradient;
  final bool frozen;

  const BankCardModel({
    required this.holderName,
    required this.maskedNumber,
    required this.expiry,
    required this.type,
    required this.gradient,
    this.frozen = false,
  });
}
