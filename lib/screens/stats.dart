import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_pulse/classes/plant.dart';
import 'package:green_pulse/classes/measure.dart';
import 'package:green_pulse/widgets/plant_found_card.dart';
import 'package:green_pulse/bloc/plants_bloc.dart';
import 'package:green_pulse/screens/plant_details.dart';

import 'home.dart';

class statsScreen extends StatefulWidget {
  const statsScreen({super.key});

  @override
  State<statsScreen> createState() => _statsScreenState();
}

Stream<List<Measure>> _getStatsFromPlant() => FirebaseFirestore.instance
    .collection('measure')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Measure.fromJson(doc.data())).toList());

Widget buildMeasures(Measure measure) => ListTile(
    leading: CircleAvatar(
      child: Text('${measure.measure_type}'),
    ),
    title: Text(measure.plant + " Value: " + measure.value.toString()),
    subtitle: Text('${measure.timestamp}'));

class _statsScreenState extends State<statsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stats from plant"),
      ),
      body: StreamBuilder<List<Measure>>(
          stream: _getStatsFromPlant(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.toString());
              return Text('Algo salio mal!');
            } else if (snapshot.hasData) {
              final measures = snapshot.data!;
              return ListView(children: measures.map(buildMeasures).toList());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
    );
  }
}
