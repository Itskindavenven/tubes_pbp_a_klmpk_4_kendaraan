import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/home/openCar.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    'Bookmarks',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40.0),
                ],
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => OpenCarPage()),
                // );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                    height: 320,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4)),
                              child: Image.asset(
                                'assets/images/car1.jpeg',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'GR YARIS',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.settings_input_component,
                                          size: 18),
                                      SizedBox(width: 4),
                                      Text('A/T'),
                                      SizedBox(width: 12),
                                      Icon(Icons.people, size: 18),
                                      SizedBox(width: 4),
                                      Text('5'),
                                      SizedBox(width: 12),
                                      Icon(Icons.car_rental, size: 18),
                                      SizedBox(width: 4),
                                      Text('2'),
                                      SizedBox(width: 12),
                                      Icon(Icons.wb_sunny, size: 18),
                                      SizedBox(width: 4),
                                      Text('A/C'),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            size: 18,
                                            color:
                                                Color.fromRGBO(127, 90, 240, 1),
                                          ),
                                          SizedBox(width: 4),
                                          Text('Instant Confirmation'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Yogyakarta'),
                                          SizedBox(width: 4),
                                          Icon(
                                            Icons.location_on,
                                            size: 18,
                                            color:
                                                Color.fromRGBO(127, 90, 240, 1),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            size: 18,
                                            color:
                                                Color.fromRGBO(127, 90, 240, 1),
                                          ),
                                          SizedBox(width: 4),
                                          Text('Free Cancellation'),
                                        ],
                                      ),
                                      SizedBox(width: 110),
                                      Row(
                                        children: [
                                          Text('Day/'),
                                          SizedBox(width: 4),
                                          Text(
                                            'Rp 500.000',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
            ],
          ),)),
    );
  }
}