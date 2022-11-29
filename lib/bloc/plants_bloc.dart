import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:green_pulse/Classes/measure.dart';
import 'package:green_pulse/Classes/plant_requirements.dart';
import 'package:green_pulse/classes/found_plant.dart';
import 'package:green_pulse/classes/plant.dart';
import 'package:green_pulse/repositories/plants_api.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'plants_event.dart';
part 'plants_state.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  PlantsBloc() : super(PlantsInitial()) {
    on<SearchPlantsEvent>(_searchForPlants);
    on<SeePlantDetailsEvent>(_seeDetails);
    on<LoadFavPlantsEvent>(_getPlants);
    on<DeselectPlantEvent>(_deselectPlant);
    on<SelectPlantEvent>(_selectPlant);
  }

  Future<FutureOr<void>> _selectPlant(
      SelectPlantEvent event, Emitter<PlantsState> emit) async {
    final measureSoilDoc = await FirebaseFirestore.instance
        .collection('measure_type')
        .doc('soil_moist');
    final measureHumDoc = await FirebaseFirestore.instance
        .collection('measure_type')
        .doc('humidity');
    final measureTempDoc = await FirebaseFirestore.instance
        .collection('measure_type')
        .doc('temperature');
    final measureLightDoc = await FirebaseFirestore.instance
        .collection('measure_type')
        .doc('light');
    final plantToDeselect = await FirebaseFirestore.instance
        .collection('plant')
        .where('selected', isEqualTo: true)
        .get();

    if (plantToDeselect.size == 1) {
      final plantToDeselectDoc = plantToDeselect.docs.first.reference;

      await plantToDeselectDoc.update({
        'selected': false,
      });
    }

    final plant =
        await FirebaseFirestore.instance.collection('plant').doc(event.idPlant);

    await plant.update({
      'selected': true,
    });

    final finalDocPlantTemp = await FirebaseFirestore.instance
        .collection('measure')
        .where('plant', isEqualTo: plant)
        .where('measure_type', isEqualTo: measureTempDoc)
        .orderBy('timestamp', descending: true)
        .get();
    final finalDocPlantLux = await FirebaseFirestore.instance
        .collection('measure')
        .where('plant', isEqualTo: plant)
        .where('measure_type', isEqualTo: measureLightDoc)
        .orderBy('timestamp', descending: true)
        .get();
    final finalDocPlantSoil = await FirebaseFirestore.instance
        .collection('measure')
        .where('plant', isEqualTo: plant)
        .where('measure_type', isEqualTo: measureSoilDoc)
        .orderBy('timestamp', descending: true)
        .get();
    final finalDocPlantHum = await FirebaseFirestore.instance
        .collection('measure')
        .where('plant', isEqualTo: plant)
        .where('measure_type', isEqualTo: measureHumDoc)
        .orderBy('timestamp', descending: true)
        .get();

    final finalDocPlant = await FirebaseFirestore.instance
        .collection('plant')
        .doc(event.idPlant)
        .get();

    Measure temp = Measure(
        measure_type: measureTempDoc, plant: plant, timestamp: "", value: 0);
    Measure soil = Measure(
        measure_type: measureSoilDoc, plant: plant, timestamp: "", value: 0);
    Measure hum = Measure(
        measure_type: measureHumDoc, plant: plant, timestamp: "", value: 0);
    Measure lux = Measure(
        measure_type: measureLightDoc, plant: plant, timestamp: "", value: 0);

    if (finalDocPlantTemp.size >= 1 &&
        finalDocPlantLux.size >= 1 &&
        finalDocPlantSoil.size >= 1 &&
        finalDocPlantHum.size >= 1) {
      Map<String, dynamic>? dataTemp = finalDocPlantTemp.docs.first.data();
      Map<String, dynamic>? dataLux = finalDocPlantLux.docs.first.data();
      Map<String, dynamic>? dataSoil = finalDocPlantSoil.docs.first.data();
      Map<String, dynamic>? dataHum = finalDocPlantHum.docs.first.data();
      temp = Measure.fromJson(dataTemp);
      lux = Measure.fromJson(dataLux);
      soil = Measure.fromJson(dataSoil);
      hum = Measure.fromJson(dataHum);

      final docPlantRequirementMinSoil = await FirebaseFirestore.instance
          .collection('plant_requirements')
          .where('plant', isEqualTo: plant)
          .where('measure_type', isEqualTo: measureSoilDoc)
          .where('boundary', isEqualTo: "min")
          .get();
      final docPlantRequirementMaxSoil = await FirebaseFirestore.instance
          .collection('plant_requirements')
          .where('plant', isEqualTo: plant)
          .where('measure_type', isEqualTo: measureSoilDoc)
          .where('boundary', isEqualTo: "max")
          .get();
      final docPlantRequirementMinLux = await FirebaseFirestore.instance
          .collection('plant_requirements')
          .where('plant', isEqualTo: plant)
          .where('measure_type', isEqualTo: measureLightDoc)
          .where('boundary', isEqualTo: "min")
          .get();
      final docPlantRequirementMaxLux = await FirebaseFirestore.instance
          .collection('plant_requirements')
          .where('plant', isEqualTo: plant)
          .where('measure_type', isEqualTo: measureLightDoc)
          .where('boundary', isEqualTo: "max")
          .get();
      final docPlantRequirementMinHum = await FirebaseFirestore.instance
          .collection('plant_requirements')
          .where('plant', isEqualTo: plant)
          .where('measure_type', isEqualTo: measureHumDoc)
          .where('boundary', isEqualTo: "min")
          .get();
      final docPlantRequirementMaxHum = await FirebaseFirestore.instance
          .collection('plant_requirements')
          .where('plant', isEqualTo: plant)
          .where('measure_type', isEqualTo: measureHumDoc)
          .where('boundary', isEqualTo: "max")
          .get();
      final docPlantRequirementMinTemp = await FirebaseFirestore.instance
          .collection('plant_requirements')
          .where('plant', isEqualTo: plant)
          .where('measure_type', isEqualTo: measureTempDoc)
          .where('boundary', isEqualTo: "min")
          .get();
      final docPlantRequirementMaxTemp = await FirebaseFirestore.instance
          .collection('plant_requirements')
          .where('plant', isEqualTo: plant)
          .where('measure_type', isEqualTo: measureTempDoc)
          .where('boundary', isEqualTo: "max")
          .get();

      Map<String, dynamic>? dataMinSoil =
          docPlantRequirementMinSoil.docs.first.data();
      Map<String, dynamic>? dataMinLux =
          docPlantRequirementMinLux.docs.first.data();
      Map<String, dynamic>? dataMinTemp =
          docPlantRequirementMinTemp.docs.first.data();
      Map<String, dynamic>? dataMinHum =
          docPlantRequirementMinHum.docs.first.data();
      PlantRequirements minTemp = PlantRequirements.fromJson(dataMinTemp);
      PlantRequirements minLux = PlantRequirements.fromJson(dataMinLux);
      PlantRequirements minHum = PlantRequirements.fromJson(dataMinHum);
      PlantRequirements minSoil = PlantRequirements.fromJson(dataMinSoil);
      Map<String, dynamic>? dataMaxSoil =
          docPlantRequirementMaxSoil.docs.first.data();
      Map<String, dynamic>? dataMaxLux =
          docPlantRequirementMaxLux.docs.first.data();
      Map<String, dynamic>? dataMaxTemp =
          docPlantRequirementMaxTemp.docs.first.data();
      Map<String, dynamic>? dataMaxHum =
          docPlantRequirementMaxHum.docs.first.data();
      PlantRequirements maxTemp = PlantRequirements.fromJson(dataMaxTemp);
      PlantRequirements maxLux = PlantRequirements.fromJson(dataMaxLux);
      PlantRequirements maxHum = PlantRequirements.fromJson(dataMaxHum);
      PlantRequirements maxSoil = PlantRequirements.fromJson(dataMaxSoil);

      Map<String, dynamic>? data = await finalDocPlant.data();

      Plant finalPlant = Plant.fromJson(data!);

      emit(SelectedbooStatsPlantState(finalPlant, temp, hum, soil, lux, minTemp,
          minLux, minHum, minSoil, maxTemp, maxLux, maxHum, maxSoil));
    }

    Map<String, dynamic>? data = await finalDocPlant.data();

    Plant finalPlant = Plant.fromJson(data!);

    emit(SelectedbooPlantState(finalPlant, temp, lux, soil, hum));
  }

  Future<FutureOr<void>> _deselectPlant(
      DeselectPlantEvent event, Emitter<PlantsState> emit) async {
    final plant =
        await FirebaseFirestore.instance.collection('plant').doc(event.idPlant);

    await plant.update({
      'selected': false,
    });
    final finalDocPlant = await FirebaseFirestore.instance
        .collection('plant')
        .doc(event.idPlant)
        .get();

    Map<String, dynamic>? data = await finalDocPlant.data();
    Plant finalPlant = Plant.fromJson(data!);

    emit(DeselectedPlantsState(finalPlant));
  }

  Future<FutureOr<void>> _getPlants(
      LoadFavPlantsEvent event, Emitter<PlantsState> emit) async {
    Stream<List<Plant>> plants = await FirebaseFirestore.instance
        .collection('plant')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Plant.fromJson(doc.data())).toList());

    emit(FoundFavPlantsState(plants));
  }

  Future<FutureOr<void>> _searchForPlants(
      SearchPlantsEvent event, Emitter<PlantsState> emit) async {
    List<FoundPlant> foundPlants = [];
    var apiCaller = PlantsAPI();
    try {
      Response response = await apiCaller.getPlants(event.inputSearch);
      if (response.statusCode != 404) {
        try {
          foundPlants = apiCaller.decodePlantsResponse(response);
          if (foundPlants.isEmpty) {
            emit(ErrorPlantsState(
                'There are no results in your search, please try again..'));
            return null;
          }
        } catch (e) {
          emit(ErrorPlantsState(
              'There was a connection error, please try again'));

          return null;
        }
      }
    } catch (e) {
      print(e);
      emit(ErrorPlantsState('There was a unkown error, please try again'));
      return null;
    }
    emit(FoundPlantsState(foundPlants));
  }

  Future<FutureOr<void>> _seeDetails(
      SeePlantDetailsEvent event, Emitter<PlantsState> emit) async {
    var apiCaller = PlantsAPI();
    Response response = await apiCaller.getPlantDetails(event.plant.pid);
    Plant plant = apiCaller.decodeDetailsResponse(response);

    emit(SelectedPlantState(plant));
  }
}
