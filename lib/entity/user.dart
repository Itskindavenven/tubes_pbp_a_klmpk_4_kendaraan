import 'dart:convert';

class User {
  final int? id;

  String? username, email, password, tglLahir, noTelp, image;

  User(
      {this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.noTelp,
      required this.tglLahir,
      this.image});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      noTelp: json['noTelp'],
      tglLahir: json['tglLahir'],
      image: json['image']);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'noTelp': noTelp,
        'tglLahir': tglLahir,
        'image': image
      };
}
