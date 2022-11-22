import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_pulse/classes/measure.dart';
import 'package:green_pulse/classes/plant.dart';

class statsScreen extends StatefulWidget {
  const statsScreen({super.key});

  @override
  State<statsScreen> createState() => _statsScreenState();
}

Stream<List<Measure>> _getStatsFromPlant() {
  return FirebaseFirestore.instance.collection('measure').snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Measure.fromJson(doc.data())).toList());
}

Widget buildMeasures(Measure measure, Plant plant) {
  print(measure.plant);
  print(plant.id);
  if (measure.plant == plant.id) {
    return Text("");
  }
  return ListTile(
      leading: CircleAvatar(),
      title: Text(
        "Value: " + measure.value.toString(),
        style: TextStyle(fontSize: 21.33, fontWeight: FontWeight.bold),
      ),
      subtitle: Text('${measure.timestamp}' + " mins ago"));
}

class _statsScreenState extends State<statsScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> params =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    Plant plant = params[0];

    return Scaffold(
      appBar: AppBar(
        title: Text("Stats from plant"),
      ),
      body: StreamBuilder<List<Measure>>(
          stream: _getStatsFromPlant(),
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
