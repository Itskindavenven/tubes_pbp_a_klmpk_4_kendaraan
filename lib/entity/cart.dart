import 'dart:convert';

class Cart {
  final int? id, id_car, id_user;
  int? day, price;
  String carName, pickup_date, return_date, location;
  Cart({
    this.id,
    required this.id_user,
    required this.id_car,
    required this.carName,
    required this.day,
    required this.price,
    required this.pickup_date,
    required this.return_date,
    required this.location,
  });

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      id: json['id'],
      id_user: json['id_user'],
      id_car: json['id_car'],
      carName: json['carName'],
      day: json['day'],
      price: json['price'],
      pickup_date: json['pickup_date'],
      return_date: json['return_date'],
      location: json['location']);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': id_user,
        'id_car': id_car,
        'carName': carName,
        'day': day,
        'price': price,
        'pickup_date': pickup_date,
        'return_date': return_date,
        'location': location,
      };
}
