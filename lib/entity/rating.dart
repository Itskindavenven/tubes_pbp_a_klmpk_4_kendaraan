import 'dart:convert';

class Rating {
  final int? id;
  int? id_car, bintang;
  String? deskripsi;

  Rating({
    this.id,
    required this.id_car,
    required this.bintang,
    required this.deskripsi,
  });

  factory Rating.fromRawJson(String str) => Rating.fromJson(json.decode(str));
  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json['id'],
        id_car: json['id_car'],
        bintang: json['bintang'],
        deskripsi: json['deskripsi'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'id_car': id_car,
        'bintang': bintang,
        'deskripsi': deskripsi,
      };
}
