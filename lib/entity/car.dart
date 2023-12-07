import 'dart:convert';

class Car {
  final int? id_car;
  int kursi, gps, bluetooth;
  double harga, fuel;
  String image_car, nama, merk, max_power, transmisi, max_speed;
  Car(
      {required this.id_car,
      required this.nama,
      required this.merk,
      required this.max_power,
      required this.fuel,
      required this.transmisi,
      required this.max_speed,
      required this.kursi,
      required this.gps,
      required this.bluetooth,
      required this.harga,
      required this.image_car});

  factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));
  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id_car: json['id_car'],
        nama: json['nama'],
        merk: json['merk'],
        max_power: json['max_power'],
        fuel: (json['fuel'] is int)
            ? (json['fuel'] as int).toDouble()
            : json['fuel'],
        transmisi: json['transmisi'],
        max_speed: json['max_speed'],
        kursi: json['kursi'],
        gps: json['gps'],
        bluetooth: json['bluetooth'],
        harga: (json['harga'] is int)
            ? (json['harga'] as int).toDouble()
            : json['harga'],
        image_car: json['image_car'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id_car': id_car,
        'nama': nama,
        'merk': merk,
        'max_power': max_power,
        'fuel': fuel,
        'transmisi': transmisi,
        'max_speed': max_speed,
        'kursi': kursi,
        'gps': gps,
        'bluetooth': bluetooth,
        'harga': harga,
        'image_car': image_car,
      };
}
