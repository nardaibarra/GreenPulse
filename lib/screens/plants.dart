import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_pulse/classes/plant.dart';
import 'package:green_pulse/screens/stats.dart';
import 'package:green_pulse/widgets/plant_found_card.dart';
import 'package:green_pulse/bloc/plants_bloc.dart';
import 'package:green_pulse/screens/plant_details.dart';

class plantsScreen extends StatefulWidget {
  const plantsScreen({super.key});

  @override
  State<plantsScreen> createState() => _plantsScreenState();
}

Stream<List<Plant>> _getPlants() => FirebaseFirestore.instance
    .collection('plantas')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Plant.fromJson(doc.data())).toList());

Widget buildPlants(Plant plant) => ListTile(
    leading: CircleAvatar(
      backgroundImage: NetworkImage(plant.image_url),
      // child: Text('${plant.name}'),
    ),
    title: Text(plant.display_pid + " Name: " + plant.name),
    subtitle: Text('${plant.category}'));

class _plantsScreenState extends State<plantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Plants"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const statsScreen()),
              );
            },
            icon: FaIcon(FontAwesomeIcons.pagelines),
            color: Color.fromARGB(255, 119, 83, 29),
            iconSize: 50,
          ),
        ],
      ),
      body: StreamBuilder<List<Plant>>(
          stream: _getPlants(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Text('Algo salio mal!');
            } else if (snapshot.hasData) {
              final plants = snapshot.data!;
              return ListView(children: plants.map(buildPlants).toList());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
    );
  }
}
