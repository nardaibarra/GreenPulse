import 'package:flutter/material.dart';
import 'package:green_pulse/Classes/plant.dart';

class PlantDetails extends StatefulWidget {
  const PlantDetails({super.key});

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> params =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    Plant plant = params[0];
    return Scaffold(
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
              overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10)),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Color.fromARGB(255, 29, 119, 32),
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
              onPressed: (() {}),
              child: const Text('Add plant'),
            ),
          )
        ],
      ),
    ));
  }
}
