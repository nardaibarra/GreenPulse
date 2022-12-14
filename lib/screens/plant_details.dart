import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_pulse/Classes/plant_requirements.dart';
import 'package:green_pulse/classes/plant.dart';

class PlantDetails extends StatefulWidget {
  const PlantDetails({super.key});

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<dynamic> params =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    Plant plant = params[0];
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade100,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height / 8,
                  backgroundImage: NetworkImage(plant.image_url),
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                plant.alias,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(plant.display_pid,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
              Text('category:${plant.category}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10)),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: Color.fromARGB(255, 29, 119, 32),
                  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  onPressed: (() {
                    _displayTextInputDialog(context, _nameController, plant);
                  }),
                  child: const Text('Add plant'),
                ),
              )
            ],
          ),
        ));
  }
}

Future _createPlant(Plant plant, String name) async {
  final measureSoilDoc =
      FirebaseFirestore.instance.collection('measure_type').doc('soil_moist');
  final measureHumDoc =
      FirebaseFirestore.instance.collection('measure_type').doc('humidity');
  final measureTempDoc =
      FirebaseFirestore.instance.collection('measure_type').doc('temperature');
  final measureLightDoc =
      FirebaseFirestore.instance.collection('measure_type').doc('light');

  final docPlant = FirebaseFirestore.instance.collection('plant').doc();
  final docPlantRequirementMinSoil =
      FirebaseFirestore.instance.collection('plant_requirements').doc();
  final docPlantRequirementMaxSoil =
      FirebaseFirestore.instance.collection('plant_requirements').doc();
  final docPlantRequirementMinLux =
      FirebaseFirestore.instance.collection('plant_requirements').doc();
  final docPlantRequirementMaxLux =
      FirebaseFirestore.instance.collection('plant_requirements').doc();
  final docPlantRequirementMinHum =
      FirebaseFirestore.instance.collection('plant_requirements').doc();
  final docPlantRequirementMaxHum =
      FirebaseFirestore.instance.collection('plant_requirements').doc();
  final docPlantRequirementMinTemp =
      FirebaseFirestore.instance.collection('plant_requirements').doc();
  final docPlantRequirementMaxTemp =
      FirebaseFirestore.instance.collection('plant_requirements').doc();

  PlantRequirements minTemp = PlantRequirements(
      boundary: "min",
      measure_type: measureTempDoc,
      plant: docPlant,
      value: plant.min_temp);
  PlantRequirements minLux = PlantRequirements(
      boundary: "min",
      measure_type: measureLightDoc,
      plant: docPlant,
      value: plant.min_light_lux);
  PlantRequirements minHum = PlantRequirements(
      boundary: "min",
      measure_type: measureHumDoc,
      plant: docPlant,
      value: plant.min_env_humid);
  PlantRequirements minSoil = PlantRequirements(
      boundary: "min",
      measure_type: measureSoilDoc,
      plant: docPlant,
      value: plant.min_soil_moist);
  PlantRequirements maxTemp = PlantRequirements(
      boundary: "max",
      measure_type: measureTempDoc,
      plant: docPlant,
      value: plant.max_temp);
  PlantRequirements maxLux = PlantRequirements(
      boundary: "max",
      measure_type: measureLightDoc,
      plant: docPlant,
      value: plant.max_light_lux);
  PlantRequirements maxHum = PlantRequirements(
      boundary: "max",
      measure_type: measureHumDoc,
      plant: docPlant,
      value: plant.max_env_humid);
  PlantRequirements maxSoil = PlantRequirements(
      boundary: "max",
      measure_type: measureSoilDoc,
      plant: docPlant,
      value: plant.max_soil_moist);

  plant.id = docPlant.id;
  plant.name = name;
  final json = plant.toJson();
  final jsonMaxTemp = maxTemp.toJson();
  final jsonMaxHum = maxHum.toJson();
  final jsonMaxSoil = maxSoil.toJson();
  final jsonMaxLux = maxLux.toJson();
  final jsonMinTemp = minTemp.toJson();
  final jsonMinHum = minHum.toJson();
  final jsonMinSoil = minSoil.toJson();
  final jsonMinLux = minLux.toJson();
  await docPlant.set(json);
  await docPlantRequirementMaxHum.set(jsonMaxHum);
  await docPlantRequirementMaxTemp.set(jsonMaxTemp);
  await docPlantRequirementMaxSoil.set(jsonMaxSoil);
  await docPlantRequirementMaxLux.set(jsonMaxLux);
  await docPlantRequirementMinTemp.set(jsonMinTemp);
  await docPlantRequirementMinHum.set(jsonMinHum);
  await docPlantRequirementMinSoil.set(jsonMinSoil);
  await docPlantRequirementMinLux.set(jsonMinLux);
}

Stream<List<Plant>> _getPlants() =>
    FirebaseFirestore.instance.collection('plant').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Plant.fromJson(doc.data())).toList());

_displayTextInputDialog(
    BuildContext context, TextEditingController name, Plant plant) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('Write an alias for your plant'),
            backgroundColor: Colors.grey.shade100,
            content: TextField(
              controller: name,
              cursorColor: Colors.grey.shade600,
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                labelText: 'My bedroom plant',
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.transparent)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Color.fromARGB(255, 29, 119, 32),
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                child: Text('Add'),
                onPressed: () {
                  _createPlant(plant, name.text);
                  print(_getPlants().toString());
                  Navigator.pop(context);
                },
              ),
            ]);
      });
}
