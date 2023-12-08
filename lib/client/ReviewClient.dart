// import 'dart:ffi';
import 'package:pbp_widget_a_klmpk4/entity/review.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class reviewClient {
  // url HP, di command aja jgn di hapus
  // static final String url = '192.168.1.7';
  // static final String endpoint = '/api_pbp_tubes_sewa_mobil/public/api';

  // url HP (thetering), di command aja jgn di hapus
  static final String url = '10.5.2.41';
  static final String endpoint = '/api_pbp_tubes_sewa_mobil/public/api';

  // static final String url = '10.0.2.2:8000';
  // static final String endpoint = '/api';

  static Future<List<Review>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, "$endpoint/review"));
      print('Raw JSON response: ${response.body}');
      print('Response status code: ${response.statusCode}');
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch reviews: ${response.reasonPhrase}');
      }
      print("pass");
      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Review.fromJson(e)).toList();
    } catch (e) {
      print("lewat");
      return Future.error(e.toString());
    }
  }

  static Future<List<Review>> fetchAllByUser(id_user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userIdtemp = prefs.getInt('userId');
      int userId = userIdtemp!;
      print(userId);
      var response = await get(Uri.http(url, "$endpoint/review/user/$userId"));
      print(response.statusCode);

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Review.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Review> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/review/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Review.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Review review) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/review'),
          headers: {"Content-Type": "application/json"},
          body: review.toRawJson());
      print(response.body);
      // if (response.statusCode == 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Review Review) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/review/${Review.id}'),
          headers: {"Content-Type": "application/json"},
          body: Review.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/review/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
