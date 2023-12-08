import 'package:pbp_widget_a_klmpk4/entity/subs.dart';
import 'package:pbp_widget_a_klmpk4/entity/user.dart';

import 'dart:convert';
import 'package:http/http.dart';
// import 'package:test/expect.dart';

class SubsClient {
  // url HP, di command aja jgn di hapus
  static final String url = '10.5.2.41';
  static final String endpoint = 'api_pbp_tubes_sewa_mobil/public/api';
  // static const String url = '10.0.2.2:8000';
  // static const String endpoint = '/api';

  static Future<List<Subscription>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, "$endpoint/subscriptions"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Subscription.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Subscription> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/subscriptions/$id'));

      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return Subscription.fromJson(json.decode(response.body)['data'][0]);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Subscription subscription) async {
    try {
      if (subscription.idUser == null ||
          subscription.tipe == null ||
          subscription.harga == null ||
          subscription.deskripsi == null) {
        // Mengembalikan status code 400 jika ada data yang tidak valid
        // '127.0.0.1:8000'
        var response = await post(Uri.http(url, '$endpoint/subscriptions'),
            headers: {"Content-Type": "application/json"},
            body: subscription.toRawJson());
        return response;
      }
      var response = await post(Uri.http(url, '$endpoint/subscriptions'),
          headers: {"Content-Type": "application/json"},
          body: subscription.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Subscription subs) async {
    // print("babi ${subs.id}");
    try {
      var response = await put(
          Uri.http(url, '$endpoint/subscriptions/update/${subs.id}'),
          headers: {"Content-Type": "application/json"},
          body: subs.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/subscriptions/$id'));

      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
