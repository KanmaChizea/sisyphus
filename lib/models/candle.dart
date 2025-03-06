import 'package:equatable/equatable.dart';
import 'package:sisyphus/utils/helpers/formatters.dart';

class Candle extends Equatable {
  final List<double> volumes;
  final List<String> dates;
  final String symbol;
  final List<List<double>> data; // [open,close, low, high, volume]
  const Candle({
    required this.volumes,
    required this.dates,
    required this.data,
    required this.symbol,
  });
  @override
  List<Object> get props => [volumes, dates, data];

  Candle updateWith(Candle candle) {
    return Candle(
      symbol: candle.symbol,
      volumes: [...candle.volumes, ...volumes],
      dates: [...candle.dates, ...dates],
      data: [...candle.data, ...data],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'volumes': volumes, 'dates': dates, 'data': data};
  }

  factory Candle.fromMap(Map<String, dynamic> map) {
    return Candle(
      symbol: map['s'],
      volumes: [double.tryParse(map['k']['v']) ?? 0],
      dates: [Formatters.date(map['k']['t'], 'dd/MM')],
      data: [
        [
          double.tryParse(map['k']['o']) ?? 0,
          double.tryParse(map['k']['c']) ?? 0,
          double.tryParse(map['k']['l']) ?? 0,
          double.tryParse(map['k']['h']) ?? 0,
          double.tryParse(map['k']['v']) ?? 0,
        ],
      ],
    );
  }

  @override
  bool get stringify => true;
}
