import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_pulse/Classes/plant.dart';
import 'package:green_pulse/classes/measure.dart';

class selectedStats extends StatefulWidget {
  const selectedStats({super.key, required this.plant});

  final Plant plant;
  @override
  State<selectedStats> createState() => _selectedStatsState();
}

class _selectedStatsState extends State<selectedStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.plant.name}'),
      ),
    );
  }
}
