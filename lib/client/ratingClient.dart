// import 'dart:ffi';
import 'package:pbp_widget_a_klmpk4/entity/rating.dart';
import 'dart:convert';
import 'package:http/http.dart';

class ratingClient {
  // url HP, di command aja jgn di hapus
  static final String url = '20.243.16.126:8000';
  static final String endpoint = '/api';

  // url HP (thetering), di command aja jgn di hapus
  // static final String url = '192.168.100.14';
  // static final String endpoint = '/api_pbp_tubes_sewa_mobil/public/api';

  // static final String url = '10.0.2.2:8000';
  // static final String endpoint = '/api';

  static Future<List<Rating>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, "$endpoint/rating"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Rating.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Rating> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/rating/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Rating.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Rating rating) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/rating'),
          headers: {"Content-Type": "application/json"},
          body: rating.toRawJson());
      print(response.body);
      if (response.statusCode == 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Rating rating) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/rating/${rating.id}'),
          headers: {"Content-Type": "application/json"},
          body: rating.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> delete(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/rating/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}