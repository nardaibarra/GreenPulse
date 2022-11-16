import 'package:cloud_firestore/cloud_firestore.dart';

class PlantRequirements {
  String boundary;
  DocumentReference<Map<String, dynamic>> plant;
  DocumentReference<Map<String, dynamic>> measure_type;
  int value;

  PlantRequirements(
      {required this.boundary,
      required this.plant,
      required this.measure_type,
      required this.value});
  Map<String, dynamic> toJson() => {
        'boundary': boundary,
        'plant': plant,
        'measure_type': measure_type,
        'value': value
      };

  static PlantRequirements fromJson(Map<String, dynamic> json) =>
      PlantRequirements(
          boundary: json['boundary'],
          plant: json['plant'],
          measure_type: json['value'],
          value: json['value']);
}
