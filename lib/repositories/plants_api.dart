import 'package:green_pulse/Classes/found_plant.dart';
import 'package:green_pulse/secret/plantsAPI_token.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert' as convert;

class PlantsAPI {
  static final PlantsAPI _singleton = PlantsAPI._internal();

  factory PlantsAPI() {
    return _singleton;
  }

  Future<Response> getPlants(String plant) async {
    String token = PLANTS_API_TOKEN;
    Map<String, String> qParams = {'alias': plant};
    var header = {'Authorization': 'Bearer $token'};

    var url = Uri.https('open.plantbook.io', 'api/v1/plant/search', qParams);
    Response response = await http.get(url, headers: header);
    print(response.body);
    print(response.statusCode);
    return response;
  }

  Future<Response> getPlantDetails(String pid) async {
    String token = PLANTS_API_TOKEN;
    var header = {'Authorization': 'Bearer $token'};

    var url = Uri.https(
      'open.plantbook.io',
      'api/v1/plant/detail/${pid}',
    );
    Response response = await http.get(url, headers: header);
    print(response.body);
    print(response.statusCode);
    return response;
  }

  List<FoundPlant> decodeResponse(Response response) {
    List<FoundPlant> results = [];
    var info = convert.jsonDecode(response.body);
    info = info['results'];
    if (info == null) {
      return results;
    }

    try {
      info.forEach((element) {
        String pid = element['pid'] ?? '-';
        String display_pid = element['display_pid'] ?? '-';
        String alias = element['alias'] ?? '-';
        results
            .add(FoundPlant(pid: pid, display_pid: display_pid, alias: alias));
      });
    } catch (e) {
      print(e);
    }
    return results;
  }

  PlantsAPI._internal();
}
