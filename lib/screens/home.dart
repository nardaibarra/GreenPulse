import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_pulse/Classes/plant.dart';
import 'package:green_pulse/Widgets/plant_found_card.dart';
import 'package:green_pulse/bloc/plants_bloc.dart';
import 'package:green_pulse/screens/plant_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();
  var _mainMsg = 'Type something to search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.all(8),
              child: IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.pagelines),
                color: Color.fromARGB(255, 29, 119, 32),
                iconSize: 50,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hi, Plant Lover',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.15),
                  ),
                ]),
            alignment: Alignment.topCenter,
            child: TextField(
              controller: _searchController,
              cursorColor: Colors.grey.shade600,
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                labelText: 'Search for a plant name',
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.transparent)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 4, 4, 4),
                  ),
                  onPressed: () {
                    BlocProvider.of<PlantsBloc>(context).add(
                        SearchPlantsEvent(inputSearch: _searchController.text));
                  },
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          BlocConsumer<PlantsBloc, PlantsState>(listener: (context, state) {
            if (state is PlantsInitial) {
              _mainMsg = 'Type something to search';
            }
            if (state is SelectedPlantState) {
              navigateToSelectedPlantsPage(context, state);
            }
            if (state is ErrorPlantsState) {
              _mainMsg = state.error;
            }
          }, builder: (context, state) {
            if (state is FoundPlantsState) {
              return _foundPlantListView(context, state);
            } else
              return _defaultView(context, this._mainMsg);
          }),
          // StreamBuilder<List<Plant>>(
          //     stream: _getPlants(),
          //     builder: ((context, snapshot) {
          //       if (snapshot.hasError) {
          //         print("Entro 1;");
          //         return Text('Algo salio mal!');
          //       } else if (snapshot.hasData) {
          //         print("Entro 2;");
          //         final plants = snapshot.data!;
          //         return ListView(children: plants.map(buildPlants).toList());
          //       } else {
          //         print("Entro 3;");
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //     }))
        ],
      ),
    );
  }

  void navigateToSelectedPlantsPage(
      BuildContext context, SelectedPlantState state) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (nextContext) => BlocProvider.value(
            value: BlocProvider.of<PlantsBloc>(context), child: PlantDetails()),
        settings: RouteSettings(arguments: [state.selectedPlant])));
  }
}

Stream<List<Plant>> _getPlants() => FirebaseFirestore.instance
    .collection('plantas')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Plant.fromJson(doc.data())).toList());

Widget buildPlants(Plant plant) => ListTile(
    leading: CircleAvatar(
      child: Text('${plant.name}'),
    ),
    title: Text(plant.display_pid),
    subtitle: Text('${plant.category}'));

Widget _foundPlantListView(BuildContext context, state) {
  return Container(
      height: MediaQuery.of(context).size.height - 176,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.foundPlants.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              child: PlantFoundCard(plant: state.foundPlants[index]),
            );
          }));
}

Widget _defaultView(BuildContext context, msg) {
  return Container(
      height: MediaQuery.of(context).size.height - 176, child: Text(msg));
}
