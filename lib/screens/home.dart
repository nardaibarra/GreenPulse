import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_pulse/repositories/plants_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
                // focusColor: Colors.grey.shade600,
                // labelStyle: TextStyle(color: Colors.grey),
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
                    // BlocProvider.of<PlantsBloc>(context).add(
                    //     SearchBookEvent(inputSearch: _searchController.text));
                  },
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          )
        ],
      ),
    );
  }
}
