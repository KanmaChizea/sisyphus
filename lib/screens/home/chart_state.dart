import 'package:equatable/equatable.dart';
import 'package:sisyphus/models/candle.dart';

enum ChartFilter { oneHr, twoHr, fourH, oneD, oneW, oneM }

extension ChartFilterExtension on ChartFilter {
  String get value {
    switch (this) {
      case ChartFilter.oneHr:
        return "1h";
      case ChartFilter.twoHr:
        return "2h";
      case ChartFilter.fourH:
        return "4h";
      case ChartFilter.oneD:
        return "1d";
      case ChartFilter.oneW:
        return "1w";
      case ChartFilter.oneM:
        return "1m";
    }
  }
}

class ChartState extends Equatable {
  final Candle? data;
  final ChartFilter filter;
  final String options;

  const ChartState({this.data, required this.filter, required this.options});

  factory ChartState.initial() =>
      const ChartState(filter: ChartFilter.oneHr, options: '');

  @override
  List<Object?> get props => [data, filter];

  ChartState copyWith({Candle? data, ChartFilter? filter, String? options}) {
    return ChartState(
      data: data ?? this.data,
      filter: filter ?? this.filter,
      options: options ?? this.options,
    );
  }
}
