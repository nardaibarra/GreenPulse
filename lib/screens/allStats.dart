import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_pulse/classes/measure.dart';
import 'package:green_pulse/classes/plant.dart';

class statsScreen extends StatefulWidget {
  const statsScreen({super.key});

  @override
  State<statsScreen> createState() => _statsScreenState();
}

Stream<List<Measure>> _getStatsFromPlant(Plant plant) {
  return FirebaseFirestore.instance
      .collection('measure')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Measure.fromJson(doc.data())).toList());
}

Widget buildMeasures(Measure measure, Plant plant) {
  print(measure.plant.id);
  if (measure.plant.id == plant.id) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: measure.measure_type.id == "soil_moist"
              ? Colors.brown
              : measure.measure_type.id == "light"
                  ? Colors.yellow
                  : measure.measure_type.id == "temperature"
                      ? Colors.red
                      : Colors.blue,
        ),
        title: Text(
          measure.measure_type.id == "light"
              ? "Value: " + measure.value.toString() + " Lux"
              : measure.measure_type.id == "soil_moist"
                  ? "Value: " + measure.value.toString() + "% Mst"
                  : measure.measure_type.id == "humidity"
                      ? "Value: " + measure.value.toString() + "% Hum"
                      : measure.measure_type.id == "temperature"
                          ? "Value: " + measure.value.toString() + "° Celsius"
                          : "Error",
          style: TextStyle(fontSize: 21.33, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${measure.timestamp}' + " mins ago"));
  } else {
    return SizedBox();
  }
}

class _statsScreenState extends State<statsScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> params =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    Plant plant = params[0];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey.shade100,
        title: Text(
          "All stats from: " + plant.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<List<Measure>>(
          stream: _getStatsFromPlant(plant),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot);
              return Text('Algo salio mal!');
            } else if (snapshot.hasData) {
              final plants = snapshot.data!;
              return _foundPlantListView(context, plants, plants.length, plant);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
    );
  }
}

Widget _foundPlantListView(
    BuildContext context, List<Measure> plants, int len, Plant plant) {
  return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: len,
          itemBuilder: (BuildContext context, index) {
            return buildMeasures(plants[index], plant);
          }));
}
