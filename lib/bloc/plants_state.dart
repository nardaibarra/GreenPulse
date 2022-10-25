part of 'plants_bloc.dart';

@immutable
abstract class PlantsState extends Equatable {
  const PlantsState();
  @override
  List<Object> get props => [];
}

class PlantsInitial extends PlantsState {}

class SelectedPlantState extends PlantsState {
  final FoundPlant selectedPlant;
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

class ErrorPlantsState extends PlantsState {
  final String error;
  ErrorPlantsState(this.error);
  List<Object> get props => [error];
}
