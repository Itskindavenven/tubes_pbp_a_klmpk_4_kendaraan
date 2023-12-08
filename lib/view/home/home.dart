import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/booking.dart';
import 'package:pbp_widget_a_klmpk4/view/history/history.dart';
import 'package:pbp_widget_a_klmpk4/view/home/bookCar.dart';
import 'package:pbp_widget_a_klmpk4/view/home/openCar.dart';
import 'package:pbp_widget_a_klmpk4/view/home/popularCity.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/profile.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/promo.dart';
import 'package:pbp_widget_a_klmpk4/theme.dart';
import 'package:pbp_widget_a_klmpk4/client/CartClient.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pbp_widget_a_klmpk4/entity/cart.dart';
import 'package:pbp_widget_a_klmpk4/entity/car.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late String _selectedCar;

  bool isDarkTheme = false;

  List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: 'Review',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
        body: Center(
          child: _selectedIndex == 2
              ? ProfilePage()
              : _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String searchQuery = '';

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
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 8.0),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Location',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Yogyakarta',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/gojohh.jpg'),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 14.0),
                          border: InputBorder.none,
                          suffixIcon: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {
                              // Search logic using searchQuery
                            },
                            child:
                                const Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Discover the latest deals and updates',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PromoPage()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/images/promo.jpeg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 150,
                        child: Center(
                          child: Text(
                            'PROMO',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              backgroundColor:
                                  const Color.fromARGB(255, 74, 73, 73)
                                      .withOpacity(0.5),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Your Cart',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(127, 90, 240, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookCarPage(
                                            id: null,
                                            id_user: null,
                                            id_car: null,
                                            carName: "",
                                            pickup_date: "",
                                            return_date: "",
                                            location: "",
                                          )),
                                );
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  height: 400,
                  width: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      // Isi itemBuilder dengan widget Anda
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OpenCarPage(
                                  id: cart[index].id,
                                  id_user: cart[index].id_user,
                                  id_car: cart[index].id_car,
                                  carName: cart[index].carName,
                                  pickup_date: cart[index].pickup_date,
                                  return_date: cart[index].return_date,
                                  location: cart[index].location,
                                ),
                              ));
                        },
                        child: Slidable(
                          actionPane: const SlidableDrawerActionPane(),
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Update',
                              color: Colors.blue,
                              icon: Icons.update,
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookCarPage(
                                      id: cart[index].id,
                                      id_user: cart[index].id_user,
                                      id_car: cart[index].id_car,
                                      carName: cart[index].carName,
                                      pickup_date: cart[index].pickup_date,
                                      return_date: cart[index].return_date,
                                      location: cart[index].location,
                                    ),
                                  ),
                                ).then((_) {
                                  setState(() {
                                    refresh();
                                  });
                                });
                              },
                            ),
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () async {
                                print('hapus id cart ke');
                                print(cart[index].id);
                                await CartClient.destroy(cart[index].id);
                                refresh();
                              },
                            ),
                          ],
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            color: const Color.fromARGB(255, 208, 205, 205),
                            child: SizedBox(
                                width: 50,
                                height: 320,
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(4)),
                                            child: FutureBuilder<String>(
                                              future: CartClient.getCarImage(
                                                  cart[index].id_car!),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator(); // tampilkan indikator loading saat menunggu
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}'); // tampilkan pesan kesalahan jika ada
                                                } else {
                                                  return Image.asset(
                                                    snapshot.data!,
                                                    width: 200,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  );
                                                }
                                              },
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  FutureBuilder<int>(
                                                    future: getCartId(),
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<int>
                                                                snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return CircularProgressIndicator(); // or your own loading widget
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                            'Error: ${snapshot.error}');
                                                      } else {
                                                        return Text(
                                                          "${cart[index].carName}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Icon(Icons.speed_sharp,
                                                      size: 18),
                                                  SizedBox(width: 4),
                                                  FutureBuilder<Car>(
                                                    future:
                                                        CartClient.getDataCar(
                                                            cart[index]
                                                                .id_car!),
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<Car>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Text(
                                                            '${snapshot.data!.max_speed}');
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                            '${snapshot.error}');
                                                      }
                                                      // By default, show a loading spinner.
                                                      return CircularProgressIndicator();
                                                    },
                                                  ),
                                                  SizedBox(width: 12),
                                                  Icon(Icons.people, size: 18),
                                                  SizedBox(width: 4),
                                                  FutureBuilder<Car>(
                                                    future:
                                                        CartClient.getDataCar(
                                                            cart[index]
                                                                .id_car!),
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<Car>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Text(
                                                            '${snapshot.data!.kursi}');
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                            '${snapshot.error}');
                                                      }
                                                      // By default, show a loading spinner.
                                                      return CircularProgressIndicator();
                                                    },
                                                  ),
                                                  SizedBox(width: 12),
                                                  Icon(
                                                      Icons
                                                          .local_gas_station_rounded,
                                                      size: 18),
                                                  SizedBox(width: 4),
                                                  FutureBuilder<Car>(
                                                    future:
                                                        CartClient.getDataCar(
                                                            cart[index]
                                                                .id_car!),
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<Car>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Text(
                                                            '${snapshot.data!.fuel} L/KM');
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                            '${snapshot.error}');
                                                      }
                                                      // By default, show a loading spinner.
                                                      return CircularProgressIndicator();
                                                    },
                                                  ),
                                                  SizedBox(width: 12),
                                                  Icon(
                                                      Icons
                                                          .shutter_speed_rounded,
                                                      size: 18),
                                                  SizedBox(width: 4),
                                                  FutureBuilder<Car>(
                                                    future:
                                                        CartClient.getDataCar(
                                                            cart[index]
                                                                .id_car!),
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<Car>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Text(
                                                            '${snapshot.data!.transmisi}');
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                            '${snapshot.error}');
                                                      }
                                                      // By default, show a loading spinner.
                                                      return CircularProgressIndicator();
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            127, 90, 240, 1),
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text(
                                                          'Pick up Date : ${cart[index].pickup_date}'),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          '${cart[index].location.split(" ")[1]}'),
                                                      SizedBox(width: 4),
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            127, 90, 240, 1),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(height: 8),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        Icons.restore_rounded,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            127, 90, 240, 1),
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text(
                                                          'Return Date : ${cart[index].return_date}'),
                                                    ],
                                                  ),
                                                  SizedBox(width: 70),
                                                  Row(
                                                    children: [
                                                      // Text(
                                                      //     '${cart[index].day} Day/'),
                                                      SizedBox(width: 2),
                                                      Text(
                                                        'Rp ${NumberFormat("#,###").format(cart[index].price)}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              127, 90, 240, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: () {
                                          // Handle love icon tap
                                        },
                                        child: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<Uint8List> __image() async {
  //   int id_cart = await CartClient.getCartDetails();
  //   var imageString = await CartClient.getCarImage(cart[index].id_car ?? 0);
  //   var image = base64Decode(imageString);

  //   return image;
  // // }
  // Future<Uint8List> __image() async {
  //   var imageString = await CartClient.getCarImage(cart[index].id_car ?? 0);
  //   var image = base64Decode(imageString);

  //   return image;
  // }

  static Future<int> getUser() async {
    int id_user = await CartClient.getUserId();

    return id_user;
  }

  static Future<int> getCartId() async {
    int id_cart = await CartClient.getCartDetails();

    return id_cart;
  }
}
