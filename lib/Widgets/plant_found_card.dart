import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlantFoundCard extends StatelessWidget {
  final Map<String, String> plant;
  PlantFoundCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  "${plant['pid']}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("${plant['display_pid']}",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                Text("${plant['category']}", style: TextStyle(fontSize: 10))
              ],
            ),
          ),
          FaIcon(FontAwesomeIcons.chevronRight)
        ],
      ),
    );
  }
}
