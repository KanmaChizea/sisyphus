import 'dart:convert';

import 'package:equatable/equatable.dart';

class Ticker extends Equatable {
  const Ticker({
    required this.changeValue,
    required this.changePercentage,
    required this.highValue,
    required this.highPercentage,
    required this.lowValue,
    required this.lowPercentage,
    required this.volumeValue,
    required this.currentRate,
  });
  final String changeValue;
  final String changePercentage;
  final String highValue;
  final String highPercentage;
  final String lowValue;
  final String lowPercentage;
  final String volumeValue;
  final String currentRate;

  factory Ticker.fromMap(Map<String, dynamic> map) {
    return Ticker(
      changeValue: map['p'] ?? '',
      changePercentage: map['P'] ?? '',
      highValue: map['h'] ?? '',
      highPercentage: map['P'] ?? '',
      lowValue: map['l'] ?? '',
      lowPercentage: map['P'] ?? '',
      volumeValue: map['v'] ?? '',
      currentRate: map['c'] ?? '',
    );
  }

  factory Ticker.fromJson(String source) =>
      Ticker.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    changeValue,
    changePercentage,
    highValue,
    highPercentage,
    lowValue,
    lowPercentage,
    volumeValue,
    currentRate,
  ];
}
