part of 'plants_bloc.dart';

@immutable
abstract class PlantsState extends Equatable {
  const PlantsState();
  @override
  List<Object> get props => [];
}

class PlantsInitial extends PlantsState {}

class SelectedPlantState extends PlantsState {
  final Plant selectedPlant;
  SelectedPlantState(this.selectedPlant);
  @override
  List<Object> get props => [selectedPlant];
}

class FoundPlantsState extends PlantsState {
  final List<dynamic> foundPlants;
  FoundPlantsState(this.foundPlants);
  @override
  List<Object> get props => [foundPlants];
}

class FoundFavPlantsState extends PlantsState {
  final Stream<List<Plant>> foundPlants;
  FoundFavPlantsState(this.foundPlants);
  @override
  List<Object> get props => [foundPlants];
}

class DeselectedPlantsState extends PlantsState {
  final Plant plant;
  DeselectedPlantsState(this.plant);
  @override
  List<Object> get props => [plant];
}

class SelectedbooPlantState extends PlantsState {
  final Plant plant;
  final Measure temp;
  final Measure hum;
  final Measure soil;
  final Measure lux;
  SelectedbooPlantState(this.plant, this.temp, this.hum, this.soil, this.lux);
  @override
  List<Object> get props => [plant, temp, hum, soil, lux];
}

class SelectedbooStatsPlantState extends PlantsState {
  final Plant plant;
  final Measure temp;
  final Measure hum;
  final Measure soil;
  final Measure lux;
  final PlantRequirements minTemp;
  final PlantRequirements minLux;
  final PlantRequirements minHum;
  final PlantRequirements minSoil;
  final PlantRequirements maxTemp;
  final PlantRequirements maxLux;
  final PlantRequirements maxHum;
  final PlantRequirements maxSoil;
  SelectedbooStatsPlantState(
      this.plant,
      this.temp,
      this.hum,
      this.soil,
      this.lux,
      this.minTemp,
      this.minLux,
      this.minHum,
      this.minSoil,
      this.maxTemp,
      this.maxLux,
      this.maxHum,
      this.maxSoil);
  @override
  List<Object> get props => [
        plant,
        temp,
        hum,
        soil,
        lux,
        minTemp,
        minLux,
        minHum,
        minSoil,
        maxTemp,
        maxLux,
        maxHum,
        maxSoil
      ];
}

class ErrorPlantsState extends PlantsState {
  final String error;
  ErrorPlantsState(this.error);
  List<Object> get props => [error];
}
