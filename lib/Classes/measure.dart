import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final finalFormat = new DateFormat('dd/MM/yyyy');

class Measure {
  final DocumentReference<Map<String, dynamic>> measure_type;
  final DocumentReference<Map<String, dynamic>> plant;
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
      timestamp: DateTime.now()
          .difference(json['timestamp'].toDate())
          .inMinutes
          .toString(),
      value: json['value']);
}
