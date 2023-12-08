import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pbp_widget_a_klmpk4/entity/car.dart';

class ReviewClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api';

  // static final String url = '192.168.100.48';
  // static final String endpoint = '/api_pbp/public/api';

  static Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdtemp = prefs.getInt('userId');
    int userId = userIdtemp!;
    return userId;
  }

  static Future<Car> getDataCar(int id_car) async {
    try {
      var response = await get(Uri.http(url, "$endpoint/car/$id_car"));

      print(id_car);

      if (response.statusCode != 200) {
        print('Error: ${response.reasonPhrase}');
        throw Exception('Failed to load car data');
      }

      if (response.body == null) {
        print('Response body is null');
        throw Exception('Failed to load car data');
      }

      Map<String, dynamic> data = json.decode(response.body);

      if (data['data'] == null) {
        print('Data is null');
        throw Exception('Failed to load car data');
      }

      return Car.fromJson(data['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
