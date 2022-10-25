import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:green_pulse/Classes/found_plant.dart';
import 'package:green_pulse/repositories/plants_api.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'plants_event.dart';
part 'plants_state.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  PlantsBloc() : super(PlantsInitial()) {
    on<SearchPlantsEvent>(_searchForPlants);
    on<SeePlantDetailsEvent>(_seeDetails);
  }

  Future<FutureOr<void>> _searchForPlants(
      SearchPlantsEvent event, Emitter<PlantsState> emit) async {
    List<FoundPlant> foundPlants = [];
    var apiCaller = PlantsAPI();
    try {
      Response response = await apiCaller.getPlants(event.inputSearch);
      if (response.statusCode != 404) {
        try {
          foundPlants = apiCaller.decodeResponse(response);
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

  FutureOr<void> _seeDetails(
      SeePlantDetailsEvent event, Emitter<PlantsState> emit) {}
}
