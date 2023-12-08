import 'dart:convert';

class Review {
  final int? id;
  int? id_user, id_car, nilai;
  String? komentar;

  Review({
    this.id,
    required this.id_user,
    required this.id_car,
    required this.komentar,
    required this.nilai,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));
  factory Review.fromJson(Map<String, dynamic> json) {
    print("nilai: ${json['nilai']}");
    return Review(
      id: json['id'],
      id_user: json['id_user'],
      id_car: json['id_car'],
      komentar: json['komentar'],
      nilai: json['nilai'],
    );
  }

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': id_user,
        'id_car': id_car,
        'komentar': komentar,
        'nilai': nilai,
      };
}