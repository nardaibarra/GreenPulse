import 'package:flutter/material.dart';
import 'package:green_pulse/repositories/plants_api.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: () {
          var api = PlantsAPI();
          api.getPlant('tulip');
          api.getPlantDetails("acer buergerianum");
        },
        child: Text('get plants'),
      ),
    );
  }
}
