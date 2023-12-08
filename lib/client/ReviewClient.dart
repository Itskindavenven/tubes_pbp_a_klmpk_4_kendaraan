import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pbp_widget_a_klmpk4/entity/car.dart';
import 'package:pbp_widget_a_klmpk4/entity/review.dart';

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

  static Future<List<Review>> fetchAll() async {
    var response = await get(Uri.http(url, "$endpoint/review"));

    print(response.statusCode);
    if (response.statusCode != 200) {
      print('Error: ${response.reasonPhrase}');
      return [];
    }

    if (response.body == null) {
      print('Response body is null');
      return [];
    }

    Map<String, dynamic> data = json.decode(response.body);

    if (data['data'] == null || data['data'].isEmpty) {
      print('Data is null or empty');
      return [];
    }

    Iterable list = data['data'];

    return list.map((e) => Review.fromJson(e)).toList();
  }

  static Future<List<Review>> fetchAllForUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdtemp = prefs.getInt('userId');

    int userId = userIdtemp!;

    var response = await get(Uri.http(url, '$endpoint/review/$userId'));
    print(response.statusCode);
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);

    Map<String, dynamic> data = json.decode(response.body);
    
    Iterable list = data['data'];
    return list.map((e) => Review.fromJson(e)).toList();
  }

  static Future<Review> find(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdtemp = prefs.getInt('userId');

    int userId = userIdtemp!;

    var response = await get(Uri.http(url, '$endpoint/review/$userId/$id'));

    print(response.statusCode);
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);

    return Review.fromJson(json.decode(response.body)['data']);
  }

  static Future<Response> create(Review review) async {
    var response = await post(Uri.http(url, '$endpoint/review'),
        headers: {"Content-Type": "application/json"},
        body: review.toRawJson());
    print(response.body);
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    return response;
  }

  // static Future<Response> update(Review review) {
  //    var response = await put(
  //         Uri.http(url, '$endpoint/review/$'),
  //         headers: {"Content-Type": "application/json"},
  //         body: cart.toRawJson());

  //     print(response.statusCode);
  //     print(response.body);
  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     return response;
  // }

  static Future<Response> destroy(id) async {
    var response = await delete(Uri.http(url, '$endpoint/review/$id'));
    print(response.statusCode);

    return response;
  }
}
