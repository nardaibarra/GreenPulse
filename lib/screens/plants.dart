import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_pulse/classes/plant.dart';
import 'package:green_pulse/screens/stats.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_pulse/bloc/plants_bloc.dart';

class plantsScreen extends StatefulWidget {
  const plantsScreen({super.key});

  @override
  State<plantsScreen> createState() => _plantsScreenState();
}

Stream<List<Plant>> _getPlants() =>
    FirebaseFirestore.instance.collection('plant').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Plant.fromJson(doc.data())).toList());

Widget buildPlants(Plant plant) => GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        margin: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: 140,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: CircleAvatar(
                radius: 1000,
                backgroundImage: NetworkImage(plant.image_url),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    plant.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(plant.display_pid,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w300)),
                  Text("Category: " + plant.category,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.circle,
                        color: plant.selected ? Colors.green : Colors.red,
                        size: 10.0,
                      ),
                      Text(plant.selected ? "Connected" : "Disconnected")
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

// ListTile(
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(plant.image_url),
//         child: Text('${plant.name}'),
//       ),
//       title: Text(plant.display_pid),
//       subtitle: Text('${plant.category}'),
//       trailing: plant.selected ? Text("Verdadero") : Text("Falso"),
//     );

class _plantsScreenState extends State<plantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey.shade100,
        title: Text(
          "My Plants",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const statsScreen()),
              );
            },
            icon: FaIcon(FontAwesomeIcons.chartLine),
            color: Color.fromARGB(255, 255, 56, 56),
          ),
        ],
      ),
      body: BlocConsumer<PlantsBloc, PlantsState>(listener: (context, state) {
        if (state is PlantsInitial) {
          print("Plants Initial!!");
          print(state);
        }
        if (state is SelectedPlantState) {
          print("Plants SelectedPlantState!!");
          print(state);
        }
        if (state is ErrorPlantsState) {
          print("Plants ErrorPlantsState!!");
          print(state);
        }
      }, builder: (context, state) {
        if (state is FoundPlantsState) {
          print("Plants FoundPlantsState!!");
          print(state);
          return Text("aa");
        } else
          print("Plants troll!!");
        print(state);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        );
      }),
    );
  }
}
