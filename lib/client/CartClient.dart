import 'package:pbp_widget_a_klmpk4/entity/cart.dart';
import 'package:pbp_widget_a_klmpk4/entity/car.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class CartClient {
  // static final String url = '10.0.2.2:8000';
  // static final String endpoint = '/api';

  static final String url = '10.5.2.41';
  static final String endpoint = 'api_pbp_tubes_sewa_mobil/public/api';

  static Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdtemp = prefs.getInt('userId');
    int userId = userIdtemp!;
    return userId;
  }

  static Future<int> getCartDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdtemp = prefs.getInt('userId');
    int userId = userIdtemp!;
    final response = await get(Uri.http(url, "$endpoint/cart/$userId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> cartData = responseData['data'];
      int id_cart = 0; // Inisialisasi id_cart
      for (var item in cartData) {
        id_cart = item[
            'id']; // Asumsikan 'id' adalah kunci untuk id keranjang dalam data API Anda
      }
      return id_cart; // Kembalikan id_cart setelah loop
    } else {
      throw Exception('Failed to load cart data');
    }
  }

  static Future<String> getCarImage(int id_car) async {
    switch (id_car) {
      case 1:
        return 'images/porsche.jpg';
      case 2:
        return 'images/ferrari.jpg';
      case 3:
        return 'images/aston.jpg';
      case 4:
        return 'images/mercy.jpg';
      case 5:
        return 'images/supra.jpg';
      case 6:
        return 'images/mclaren.jpg';
      // add more cases as needed
      default:
        throw Exception('Invalid car ID');
    }
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

  static Future<List<Cart>> fetchAll() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userIdtemp = prefs.getInt('userId');

// Cek apakah userIdtemp null
      if (userIdtemp == null) {
        print('User ID is null');
        return [];
      }

      int userId = userIdtemp;

      var response = await get(Uri.http(url, "$endpoint/cart/$userId"));

      print(response.statusCode);
      if (response.statusCode != 200) {
        print('Error: ${response.reasonPhrase}');
        return [];
      }

// Cek apakah body response null
      if (response.body == null) {
        print('Response body is null');
        return [];
      }

      Map<String, dynamic> data = json.decode(response.body);

// Cek apakah data['data'] null atau kosong
      if (data['data'] == null || data['data'].isEmpty) {
        print('Data is null or empty');
        return [];
      }

      Iterable list = data['data'];

      return list.map((e) => Cart.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Cart> find(id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userIdtemp = prefs.getInt('userId');

      int userId = userIdtemp!;

      var response = await get(Uri.http(url, '$endpoint/cart/$userId/$id'));

      print(response.statusCode);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Cart.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Cart cart) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/cart'),
          headers: {"Content-Type": "application/json"},
          body: cart.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Cart cart) async {
    try {
      var response = await put(
          Uri.http(url, '$endpoint/cart/update/${cart.id}'),
          headers: {"Content-Type": "application/json"},
          body: cart.toRawJson());

      print(response.statusCode);
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> updateIsReviewed(id) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/cart/updateStatus/$id'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"isReviewed": 1}));

      print('masuk ${response.body}');
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/cart/$id'));
      print(response.statusCode);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
