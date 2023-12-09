import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_widget_a_klmpk4/view/home/bookCar.dart';
import 'package:pbp_widget_a_klmpk4/entity/cart.dart';
import 'package:pbp_widget_a_klmpk4/entity/car.dart';
import 'package:pbp_widget_a_klmpk4/client/CartClient.dart';
import 'package:pbp_widget_a_klmpk4/scanner/scan_qr.dart';
import 'package:pbp_widget_a_klmpk4/pdf/pdf_view.dart';
import 'package:pbp_widget_a_klmpk4/view/home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OpenCarPage extends StatefulWidget {
  OpenCarPage(
      {Key? key,
      this.id,
      required this.id_user,
      required this.id_car,
      required this.carName,
      required this.pickup_date,
      required this.return_date,
      required this.location})
      : super(key: key);

  final int? id, id_car, id_user;
  int? day, price;
  String carName, pickup_date, return_date, location;

  @override
  _OpenCarPageState createState() => _OpenCarPageState();
}

class _OpenCarPageState extends State<OpenCarPage> {
  String pickupDate = '';
  String returnDate = '';
  String location = '';
  int id_cart = 0;

  @override
  void initStateId() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final cart = await CartClient.find(widget.id);
      setState(() {
        id_cart = cart.id!;
      });
    });
  }

  // @override
  // void initStateReturnDate() {
  //   super.initState();
  //   getReturnDate();
  // }

  // Future<void> getReturnDate() async {
  //   final cart = await CartClient.find(widget.id);
  //   setState(() {
  //     returnDate = cart.return_date;
  //   });
  // }

  // @override
  // void initStateLoc() {
  //   super.initState();
  //   getLoc();
  // }

  // Future<void> getLoc() async {
  //   final cart = await CartClient.find(widget.id);
  //   setState(() {
  //     pickupDate = cart.location;
  //   });
  // }

  Future<List<Map<String, dynamic>>> getSpecifications() async {
    final cart = await CartClient.find(widget.id);
    final car = await CartClient.getDataCar(cart.id_car!);

    return [
      {
        'icon': Icons.battery_full,
        'title': 'Max Power',
        'value': car.max_power,
      },
      {
        'icon': Icons.local_gas_station,
        'title': 'Fuel',
        'value': car.fuel.toString(),
      },
      {
        'icon': Icons.hourglass_bottom_rounded,
        'title': 'Acceleration',
        'value': car.transmisi,
      },
      {
        'icon': Icons.speed,
        'title': 'Max Speed',
        'value': car.max_speed,
      },
    ];
  }

  List<Cart> cart = [];
  void refresh() async {
    try {
      List<Cart> data = await CartClient.fetchAll();
      if (data == null || data.isEmpty) {
        Icons.local_grocery_store_sharp;
        print('Cart empty');
      } else {
        setState(() {
          cart = data;
        });
      }
    } catch (e) {
      Icons.local_grocery_store_sharp;
      print('Cart empty');
    }
  }

  @override
  void initState() {
    print(widget.id);
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<Cart>(
                    future: CartClient.find(widget.id),
                    builder:
                        (BuildContext context, AsyncSnapshot<Cart> snapshot) {
                      if (snapshot.hasData) {
                        return Text('${snapshot.data!.carName}',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold));
                      } else if (snapshot.hasError) {
                        return Text(
                          '${snapshot.error}',
                        );
                      }
                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20.0,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '4.8',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<Car>(
                    future: CartClient.find(widget.id)
                        .then((cart) => CartClient.getDataCar(cart.id_car!)),
                    builder:
                        (BuildContext context, AsyncSnapshot<Car> snapshot) {
                      if (snapshot.hasData) {
                        return Text('${snapshot.data!.merk}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold));
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(4)),
                      child: FutureBuilder<String>(
                        future: CartClient.find(widget.id).then(
                            (cart) => CartClient.getCarImage(cart.id_car!)),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // tampilkan indikator loading saat menunggu
                          } else if (snapshot.hasError) {
                            return Text(
                                'Error: ${snapshot.error}'); // tampilkan pesan kesalahan jika ada
                          } else {
                            return Image.asset(
                              snapshot.data!,
                              width: 400,
                              height: 200,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      )),
                  const SizedBox(height: 35),
                  const Text(
                    'Specifications',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        FutureBuilder<List<Map<String, dynamic>>>(
                          future: getSpecifications(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // tampilkan indikator loading saat menunggu
                            } else if (snapshot.hasError) {
                              return Text(
                                  'Error: ${snapshot.error}'); // tampilkan pesan kesalahan jika ada
                            } else {
                              return SizedBox(
                                height: 200, // atur tinggi yang diinginkan
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: 120,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(snapshot.data![index]
                                                  ['icon']),
                                              const SizedBox(height: 5),
                                              Text(snapshot.data![index]
                                                  ['title']),
                                              Text(
                                                snapshot.data![index]['value'],
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 5),
              FutureBuilder<Cart>(
                future: CartClient.find(widget.id),
                builder: (BuildContext context, AsyncSnapshot<Cart> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                        'Rp ${NumberFormat("#,###").format(snapshot.data!.price)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold));
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      double maxHeight =
                          MediaQuery.of(context).size.height * 0.65;

                      return Container(
                        constraints: BoxConstraints(
                          maxHeight: maxHeight,
                        ),
                        child:
                            buildCombinedBottomSheet(), // Panggil widget baru
                      );
                    },
                  );
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSpecCard(IconData icon, String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeatureRow(IconData leftIcon, String text, String rightText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                leftIcon,
                color: const Color.fromRGBO(127, 90, 240, 1),
              ),
              const SizedBox(width: 10),
              Text(text),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.door_back_door,
                color: Color.fromRGBO(127, 90, 240, 1),
              ),
              const SizedBox(width: 5),
              Text(rightText),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCombinedBottomSheet() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(127, 90, 240, 1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // children: [
                    //   FutureBuilder<Cart>(
                    //     future: CartClient.find(widget.id),
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot<Cart> snapshot) {
                    //       if (snapshot.hasData) {
                    //         return Text(
                    //           '${snapshot.data!.carName}',
                    //           style: const TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 20,
                    //             color: Colors.white,
                    //           ),
                    //         );
                    //       } else if (snapshot.hasError) {
                    //         return Text('${snapshot.error}',
                    //             style: const TextStyle(
                    //                 fontSize: 16, fontWeight: FontWeight.bold));
                    //       }
                    //       // By default, show a loading spinner.
                    //       return CircularProgressIndicator();
                    //     },
                    //   ),
                    //   FutureBuilder<Car>(
                    //     future: CartClient.find(widget.id).then(
                    //         (cart) => CartClient.getDataCar(cart.id_car!)),
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot<Car> snapshot) {
                    //       if (snapshot.hasData) {
                    //         return Text(
                    //           '${snapshot.data!.kursi} Passenger',
                    //           style: const TextStyle(
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //           ),
                    //         );
                    //       } else if (snapshot.hasError) {
                    //         return Text('${snapshot.error}',
                    //             style: const TextStyle(
                    //                 fontSize: 16, fontWeight: FontWeight.bold));
                    //       }
                    //       // By default, show a loading spinner.
                    //       return CircularProgressIndicator();
                    //     },
                    //   ),
                    // ],
                  ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.star,
                  //       color: Colors.yellow,
                  //     ),
                  //     SizedBox(width: 5),
                  //     Text(
                  //       '4.8',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            // color: Colors.grey,
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Overview',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: buildSpecCard(Icons.calendar_today, 'Start',
                        cart[id_cart].pickup_date),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildSpecCard(
                      Icons.calendar_today,
                      'End',
                      cart[id_cart].return_date,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Pick-up Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              buildSpecCard(
                Icons.location_on,
                '',
                firstFiveWords(cart[id_cart].location),
              ),
              const SizedBox(height: 10),
              const Text(
                'Payment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final cart = await CartClient.find(widget.id);
                  id_cart = cart.id!;
                  print(id_cart);
                  // Aksi yang akan dilakukan saat kartu ditekan
                  await CartClient.destroy(id_cart);
                  Fluttertoast.showToast(
                      msg: 'Pembayaran berhasil!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor:
                          Colors.green, // Warna latar belakang toast
                      textColor: Colors.white);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Homepage(),
                    ),
                  );
                },
                child: buildSpecCard(
                  Icons.credit_card,
                  'MasterCard',
                  '**** **** 1234 5678',
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final cart = await CartClient.find(widget.id);
                  id_cart = cart.id!;
                  print(id_cart);
                  // Aksi yang akan dilakukan saat kartu ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BarcodeScannerPageView(
                            id: id_cart)), // Mengarahkan ke PaymentPage
                  );
                },
                child: buildSpecCard(
                  Icons.qr_code,
                  'Scan QR',
                  'QRIS',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(127, 90, 240, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () async {
                      // Add functionality for Print PDF
                      createPdf(
                          cart[id_cart].location,
                          cart[id_cart].carName,
                          cart[id_cart].price!,
                          cart[id_cart].pickup_date,
                          cart[id_cart].return_date,
                          id_cart,
                          context);
                    },
                    child: const Text('Print PDF'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String firstFiveWords(String text) {
    List<String> words = text.split(' ');
    if (words.length > 5) {
      words = words.take(5).toList();
    }
    return words.join(' ');
  }
}
