import 'package:green_pulse/secret/plantsAPI_token.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PlantsAPI {
  static final PlantsAPI _singleton = PlantsAPI._internal();

  factory PlantsAPI() {
    return _singleton;
  }

  Future<Response> getPlant(String plant) async {
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

  PlantsAPI._internal();
}
