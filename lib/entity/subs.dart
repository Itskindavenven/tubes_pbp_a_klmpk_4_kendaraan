import 'dart:convert';

class Subscription {
  final int? id, idUser, harga;

  String? tipe, deskripsi;

  Subscription({
    this.id,
    required this.idUser,
    required this.tipe,
    required this.harga,
    required this.deskripsi,
  });

  factory Subscription.fromRawJson(String str) =>
      Subscription.fromJson(json.decode(str));
  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json['id_subs'],
        idUser: json['id_user'],
        tipe: json['tipe'],
        harga: json['harga'],
        deskripsi: json['deskripsi'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': idUser,
        'tipe': tipe,
        'harga': harga,
        'deskripsi': deskripsi,
      };
}