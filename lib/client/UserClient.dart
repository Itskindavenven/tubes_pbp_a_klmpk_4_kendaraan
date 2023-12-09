// import 'dart:ffi';

import 'package:pbp_widget_a_klmpk4/entity/user.dart';

import 'dart:convert';
import 'package:http/http.dart';
// import 'package:test/expect.dart';

class UserClient {
  // url HP, di command aja jgn di hapus
  // static final String url = '192.168.100.14';
  // static final String endpoint = 'api_pbp_tubes_sewa_mobil/public/api';
  static final String url = '20.243.16.126:8000';
  static const String endpoint = '/api';

  static Future<List<User>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, "$endpoint/user"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/user/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response?> register(User user) async {
    print(user.toRawJson());
    print("$url$endpoint/register");
    try {
      var response = await post(Uri.http(url, '$endpoint/register'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'username': user.username,
            'email': user.email,
            'password': user.password,
            'noTelp': user.noTelp,
            'tglLahir': user.tglLahir,
            'image': user.image
          }));
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User?> login(String username, String password) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/login'),
          body: {'username': username, 'password': password});

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print(User.fromJson(json.decode(response.body)['data']));
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return null;
    }
  }

  static Future<User> validasi(String email) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/validasi'),
          body: {'email': email});

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print(User.fromJson(json.decode(response.body)['data']));
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(User user) async {
    try {
      print(user.id);
      var response = await put(
          Uri.http(url, '$endpoint/user/update/${user.id}'),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> updateImage(int id, String image) async {
    print("id: $id");
    print("image: $image");
    print("$url/$endpoint/user/updateImage/$id");
    try {
      var response = await put(Uri.http(url, '$endpoint/user/updateImage/$id'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'image': image}));
      print(response.statusCode);

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
