import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_pulse/bloc/plants_bloc.dart';
import 'package:green_pulse/Classes/found_plant.dart';

class PlantFoundCard extends StatelessWidget {
  PlantFoundCard({super.key, required this.plant});
  final FoundPlant plant;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PlantsBloc>(context)
            .add(SeePlantDetailsEvent(plant: this.plant));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        margin: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 100,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    this.plant.pid,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(this.plant.display_pid,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                  Text(this.plant.alias,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10))
                ],
              ),
            ),
            FaIcon(FontAwesomeIcons.chevronRight)
          ],
        ),
      ),
    );
  }
}
