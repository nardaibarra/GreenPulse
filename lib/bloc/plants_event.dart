part of 'plants_bloc.dart';

@immutable
abstract class PlantsEvent extends Equatable {
  const PlantsEvent();
  @override
  List<Object> get props => [];
}

class SearchPlantsEvent extends PlantsEvent {
  final String inputSearch;
  SearchPlantsEvent({
    required this.inputSearch,
  });
  @override
  List<Object> get props => [inputSearch];
}

class SeePlantDetailsEvent extends PlantsEvent {
  final FoundPlant plant;
  SeePlantDetailsEvent({
    required this.plant,
  });
  @override
  List<Object> get props => [plant];
}
