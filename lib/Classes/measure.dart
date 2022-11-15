import 'dart:ffi';

class Measure {
  final String measure_type;
  final String plant;
  final String timestamp;
  final int value;

  Measure(
      {required this.measure_type,
      required this.plant,
      required this.timestamp,
      required this.value});
  Map<String, dynamic> toJson() => {
        'measure_type': measure_type,
        'plant': plant,
        'timestamp': timestamp,
        'value': value
      };

  static Measure fromJson(Map<String, dynamic> json) => Measure(
      measure_type: json['measure_type'],
      plant: json['plant'],
      timestamp: json['timestamp'],
      value: json['value']);
}
