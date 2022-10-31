import 'package:green_pulse/Classes/found_plant.dart';
import 'package:green_pulse/Classes/plant.dart';
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
    print(header);
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

  decodePlantsResponse(Response response) {
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

  decodeDetailsResponse(Response response) {
    var info = convert.jsonDecode(response.body);
    var plant;
    if (info == null) {
      return plant;
    }
    String pid = info['pid'] ?? '';
    String display_pid = info['display_pid'] ?? '';
    String alias = info['alias'] ?? '';
    String category = info['category'] ?? '';
    int max_light_lux = info['max_light_lux'] ?? -9999;
    int min_light_lux = info['min_light_lux'] ?? -9999;
    int max_temp = info['max_temp'] ?? -9999;
    int min_temp = info['min_temp'] ?? -9999;
    int max_env_humid = info['max_env_humid'] ?? -9999;
    int min_env_humid = info['min_env_humid'] ?? -9999;
    int max_soil_moist = info['max_soil_moist'] ?? -9999;
    int min_soil_moist = info['min_soil_moist'] ?? -9999;
    String image_url = info['image_url'] ?? '';
    plant = Plant(
        pid: pid,
        display_pid: display_pid,
        alias: alias,
        category: category,
        max_light_lux: max_light_lux,
        min_light_lux: min_light_lux,
        max_temp: max_temp,
        min_temp: min_temp,
        max_env_humid: max_env_humid,
        min_env_humid: min_env_humid,
        max_soil_moist: max_soil_moist,
        min_soil_moist: min_soil_moist,
        image_url: image_url);

    return plant;
  }

  PlantsAPI._internal();
}
