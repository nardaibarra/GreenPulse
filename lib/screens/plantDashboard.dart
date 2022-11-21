import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_pulse/Classes/measure.dart';
import 'package:green_pulse/Classes/plant_requirements.dart';
import 'package:green_pulse/bloc/plants_bloc.dart';
import 'package:green_pulse/classes/plant.dart';
import 'package:gauges/gauges.dart';

class favPlantDashboard extends StatefulWidget {
  const favPlantDashboard({super.key});

  @override
  State<favPlantDashboard> createState() => _favPlantDashboardState();
}

class _favPlantDashboardState extends State<favPlantDashboard> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> params =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    Plant plant = params[0];
    Measure temp =
        Measure(measure_type: "", plant: "", timestamp: "", value: 1);
    Measure soil =
        Measure(measure_type: "", plant: "", timestamp: "", value: 0);
    Measure hum = Measure(measure_type: "", plant: "", timestamp: "", value: 0);
    Measure lux = Measure(measure_type: "", plant: "", timestamp: "", value: 0);
    double minGaugeTempValue = 0;
    double maxGaugeTempValue = 100;
    double minSegmentTempYellowValue = maxGaugeTempValue / 3;
    double minSegmentTempRedValue = (maxGaugeTempValue / 3) * 2;
    double minGaugeHumValue = 0;
    double maxGaugeHumValue = 100;
    double minSegmentHumYellowValue = maxGaugeHumValue / 3;
    double minSegmentHumRedValue = (maxGaugeHumValue / 3) * 2;
    double minGaugeLuxValue = 0;
    double maxGaugeLuxValue = 100;
    double minSegmentLuxYellowValue = maxGaugeLuxValue / 3;
    double minSegmentLuxRedValue = (maxGaugeLuxValue / 3) * 2;
    double minGaugeMoistValue = 0;
    double maxGaugeMoistValue = 100;
    double minSegmentMoistYellowValue = maxGaugeMoistValue / 3;
    double minSegmentMoistRedValue = (maxGaugeMoistValue / 3) * 2;
    double pointerValueTemp = 20;
    double pointerValueLux = 20;
    double pointerValueHum = 20;
    double pointerValueSoil = 20;

    // PlantRequirements luxMax = PlantRequirements(boundary: "", plant: "", measure_type: "", value: 0)
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey.shade100,
        title: Text(plant.name, style: TextStyle(color: Colors.black)),
      ),
      body: BlocConsumer<PlantsBloc, PlantsState>(listener: (context, state) {
        if (state is PlantsInitial) {
          print("Plants Initial!!");
          print(state);
        }
        if (state is SelectedbooPlantState) {
          plant = state.plant;
          temp = state.temp;
          lux = state.lux;
          soil = state.soil;
          hum = state.hum;
        }
        if (state is SelectedbooStatsPlantState) {
          plant = state.plant;
          temp = state.temp;
          lux = state.lux;
          soil = state.soil;
          hum = state.hum;
          minGaugeTempValue = state.minTemp.value.toDouble();
          maxGaugeTempValue = state.maxTemp.value.toDouble();
          minSegmentTempYellowValue =
              (maxGaugeTempValue - minGaugeTempValue) / 3 + minGaugeTempValue;
          minSegmentTempRedValue =
              ((maxGaugeTempValue - minGaugeTempValue) / 3) * 2 +
                  minGaugeTempValue;
          minGaugeHumValue = state.minHum.value.toDouble();
          maxGaugeHumValue = state.maxHum.value.toDouble();
          minSegmentHumYellowValue =
              (maxGaugeHumValue - minGaugeHumValue) / 3 + minGaugeHumValue;
          minSegmentHumRedValue =
              ((maxGaugeHumValue - minGaugeHumValue) / 3) * 2 +
                  minGaugeHumValue;
          minGaugeLuxValue = state.minLux.value.toDouble();
          maxGaugeLuxValue = state.maxLux.value.toDouble();
          minSegmentLuxYellowValue =
              (maxGaugeLuxValue - minGaugeLuxValue) / 3 + minGaugeLuxValue;
          minSegmentLuxRedValue =
              ((maxGaugeLuxValue - minGaugeLuxValue) / 3) * 2 +
                  minGaugeLuxValue;
          minGaugeMoistValue = state.minSoil.value.toDouble();
          maxGaugeMoistValue = state.maxSoil.value.toDouble();
          minSegmentMoistYellowValue =
              (maxGaugeMoistValue - minGaugeMoistValue) / 3 +
                  minGaugeMoistValue;
          minSegmentMoistRedValue =
              ((maxGaugeMoistValue - minGaugeMoistValue) / 3) * 2 +
                  minGaugeMoistValue;
          pointerValueHum = state.hum.value.toDouble();
          pointerValueTemp = state.temp.value.toDouble();
          pointerValueSoil = state.soil.value.toDouble();
          pointerValueLux = state.lux.value.toDouble();
          print(minGaugeTempValue);
          print(maxGaugeTempValue);
          print(minSegmentTempYellowValue);
          print(minSegmentTempRedValue);
          print(minGaugeHumValue);
          print(maxGaugeHumValue);
          print(minSegmentHumYellowValue);
          print(minSegmentHumRedValue);
          print(minGaugeLuxValue);
          print(maxGaugeLuxValue);
          print(minSegmentLuxYellowValue);

          print(minSegmentLuxRedValue);
          print(minGaugeMoistValue);
          print(maxGaugeMoistValue);
          print(minSegmentMoistYellowValue);
          print(minSegmentMoistRedValue);
          print(pointerValueHum);
          print(pointerValueTemp);
          print(pointerValueSoil);
          print(pointerValueLux.toString() + " lix");
        }
        if (state is DeselectedPlantsState) {
          plant = state.plant;
        }
      }, builder: (context, state) {
        if (state is FoundFavPlantsState) {
          if (plant.selected && temp.value == 1) {
            BlocProvider.of<PlantsBloc>(context)
                .add(SelectPlantEvent(idPlant: plant.id));
          }
          return Center(
            widthFactor: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 4.33,
                  backgroundImage: NetworkImage(plant.image_url),
                ),
                Text(
                  plant.name,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 12.33,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  plant.display_pid,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 21.33,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  plant.alias,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 22.33,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  "Category: " + plant.display_pid,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 21.33,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      color: plant.selected ? Colors.green : Colors.red,
                      size: 20.0,
                    ),
                    Text(
                      plant.selected ? "Connected" : "Disconnected",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 21.33,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 21.33,
                    ),
                    Text(
                      "Metrics",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 11.33,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      Text(
                        "Temperature",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 18.33,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        temp.timestamp == ""
                            ? ""
                            : "Last read: " + temp.timestamp + " mins ago",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 22.33,
                            fontWeight: FontWeight.w300),
                      )
                    ]),
                    Column(children: [
                      Text(
                        "Air Humidity",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 18.33,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        hum.timestamp == ""
                            ? ""
                            : "Last read: " + hum.timestamp + " mins ago",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 22.33,
                            fontWeight: FontWeight.w300),
                      )
                    ]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        RadialGauge(
                          radius: MediaQuery.of(context).size.width / 9.33,
                          axes: [
                            RadialGaugeAxis(
                              color: Colors.transparent,
                              minValue: minGaugeTempValue,
                              maxValue: maxGaugeTempValue,
                              minAngle: -90, maxAngle: 90,
                              // ...
                              segments: [
                                RadialGaugeSegment(
                                  minValue: minGaugeTempValue,
                                  maxValue: minSegmentTempYellowValue,
                                  minAngle: -90,
                                  maxAngle: -30,
                                  color: Colors.green,
                                ),
                                RadialGaugeSegment(
                                  minValue: minSegmentTempYellowValue,
                                  maxValue: minSegmentTempRedValue,
                                  minAngle: -30,
                                  maxAngle: 30,
                                  color: Colors.yellow,
                                ),
                                RadialGaugeSegment(
                                  minValue: minSegmentTempRedValue,
                                  maxValue: maxGaugeTempValue,
                                  minAngle: 30,
                                  maxAngle: 90,
                                  color: Colors.red,
                                ),
                                // ...
                              ],
                              pointers: [
                                RadialNeedlePointer(
                                  minValue: minGaugeTempValue,
                                  maxValue: maxGaugeTempValue,
                                  value: pointerValueTemp,
                                  thicknessStart: 10,
                                  thicknessEnd: 0,
                                  length: 0.6,
                                  knobRadiusAbsolute: 3,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        RadialGauge(
                          radius: MediaQuery.of(context).size.width / 9.33,
                          axes: [
                            RadialGaugeAxis(
                              color: Colors.transparent,
                              minValue: minGaugeHumValue,
                              maxValue: maxGaugeHumValue, minAngle: -90,
                              maxAngle: 90,
                              // ...
                              segments: [
                                RadialGaugeSegment(
                                  minValue: minGaugeHumValue,
                                  maxValue: minSegmentHumYellowValue,
                                  minAngle: -90,
                                  maxAngle: -30,
                                  color: Colors.green,
                                ),
                                RadialGaugeSegment(
                                  minValue: minSegmentHumYellowValue,
                                  maxValue: minSegmentHumRedValue,
                                  minAngle: -30,
                                  maxAngle: 30,
                                  color: Colors.yellow,
                                ),
                                RadialGaugeSegment(
                                  minValue: minSegmentHumRedValue,
                                  maxValue: maxGaugeHumValue,
                                  minAngle: 30,
                                  maxAngle: 90,
                                  color: Colors.red,
                                ),
                                // ...
                              ],
                              pointers: [
                                RadialNeedlePointer(
                                  minValue: minGaugeHumValue,
                                  maxValue: maxGaugeHumValue,
                                  value: pointerValueHum,
                                  thicknessStart: 10,
                                  thicknessEnd: 0,
                                  length: 0.6,
                                  knobRadiusAbsolute: 3,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      Text(
                        "Soil Moisture",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 18.33,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        soil.timestamp == ""
                            ? ""
                            : "Last read: " + soil.timestamp + " mins ago",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 22.33,
                            fontWeight: FontWeight.w300),
                      )
                    ]),
                    Column(children: [
                      Text(
                        "Light",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 18.33,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        lux.timestamp == ""
                            ? ""
                            : "Last read: " + lux.timestamp + " mins ago",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 22.33,
                            fontWeight: FontWeight.w300),
                      )
                    ]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        RadialGauge(
                          radius: MediaQuery.of(context).size.width / 9.33,
                          axes: [
                            RadialGaugeAxis(
                              color: Colors.transparent,
                              minValue: minGaugeMoistValue,
                              maxValue: maxGaugeMoistValue, minAngle: -90,
                              maxAngle: 90,
                              // ...
                              segments: [
                                RadialGaugeSegment(
                                  minValue: minGaugeMoistValue,
                                  maxValue: minSegmentMoistYellowValue,
                                  minAngle: -90,
                                  maxAngle: -30,
                                  color: Colors.green,
                                ),
                                RadialGaugeSegment(
                                  minValue: minSegmentMoistYellowValue,
                                  maxValue: minSegmentMoistRedValue,
                                  minAngle: -30,
                                  maxAngle: 30,
                                  color: Colors.yellow,
                                ),
                                RadialGaugeSegment(
                                  minValue: minSegmentMoistRedValue,
                                  maxValue: maxGaugeMoistValue,
                                  minAngle: 30,
                                  maxAngle: 90,
                                  color: Colors.red,
                                ),
                                // ...
                              ],
                              pointers: [
                                RadialNeedlePointer(
                                  minValue: minGaugeMoistValue,
                                  maxValue: maxGaugeMoistValue,
                                  value: pointerValueSoil,
                                  thicknessStart: 10,
                                  thicknessEnd: 0,
                                  length: 0.6,
                                  knobRadiusAbsolute: 3,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        RadialGauge(
                          radius: MediaQuery.of(context).size.width / 9.33,
                          axes: [
                            RadialGaugeAxis(
                              color: Colors.transparent,
                              minValue: minGaugeLuxValue,
                              maxValue: maxGaugeLuxValue, minAngle: -90,
                              maxAngle: 90,
                              // ...
                              segments: [
                                RadialGaugeSegment(
                                  minValue: minGaugeLuxValue,
                                  maxValue: minSegmentLuxYellowValue,
                                  minAngle: -90,
                                  maxAngle: -30,
                                  color: Colors.green,
                                ),
                                RadialGaugeSegment(
                                  minValue: minSegmentLuxYellowValue,
                                  maxValue: minSegmentLuxRedValue,
                                  minAngle: -30,
                                  maxAngle: 30,
                                  color: Colors.yellow,
                                ),
                                RadialGaugeSegment(
                                  minValue: minSegmentLuxRedValue,
                                  maxValue: maxGaugeLuxValue,
                                  minAngle: 30,
                                  maxAngle: 90,
                                  color: Colors.red,
                                ),
                                // ...
                              ],
                              pointers: [
                                RadialNeedlePointer(
                                  minValue: minGaugeLuxValue,
                                  maxValue: maxGaugeLuxValue,
                                  value: pointerValueLux,
                                  thicknessStart: 10,
                                  thicknessEnd: 0,
                                  length: 0.6,
                                  knobRadiusAbsolute: 3,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (plant.selected) {
                            BlocProvider.of<PlantsBloc>(context)
                                .add(DeselectPlantEvent(idPlant: plant.id));
                          } else {
                            BlocProvider.of<PlantsBloc>(context)
                                .add(SelectPlantEvent(idPlant: plant.id));
                          }
                        },
                        style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll<Size>(
                                Size.fromWidth(320)),
                            backgroundColor: plant.selected
                                ? MaterialStatePropertyAll<Color>(Colors.green)
                                : MaterialStatePropertyAll<Color>(Colors.red)),
                        child: Text(
                          plant.selected ? "Disconnect" : "Connect",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width / 18.33,
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      }),
    );
  }
}