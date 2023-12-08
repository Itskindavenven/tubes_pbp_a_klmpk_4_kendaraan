import 'dart:convert';

class Review {
  final int? id, id_car, id_user;
  String deskripsi;

  Review(
      {this.id,
      required this.id_user,
      required this.id_car,
      required this.deskripsi});

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));
  factory Review.fromJson(Map<String, dynamic> json) => Review(
      id: json['id'],
      id_user: json['id_user'],
      id_car: json['id_car'],
      deskripsi: json['deskripsi']);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    'id': id,
    'id_user': id_user,
    'id_car': id_car,
    'deskripsi': deskripsi
  };
}
