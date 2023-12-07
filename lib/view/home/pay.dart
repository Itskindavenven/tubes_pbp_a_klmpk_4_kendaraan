import 'package:flutter/material.dart';

class PayPage extends StatefulWidget {
  final String startDateTime;
  final String endDateTime;
  final String pickupLocation;

  const PayPage({
    required this.startDateTime,
    required this.endDateTime,
    required this.pickupLocation,
  });

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke BookCarPage
                    },
                  ),
                  const Text(
                    'Date & Time',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 40.0), // Spacer
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                  color: Color.fromRGBO(127, 90, 240, 1),
                ),
                padding: const EdgeInsets.all(15.0),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GR YARIS',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          '2 Passengers',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          '4.8',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 4.0,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Overview',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Start',
                                ),
                                Text(
                                  widget.startDateTime,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ), // Data dari BookCarPage
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('End'),
                                Text(
                                  widget.endDateTime,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ), // Data dari BookCarPage
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Pick-up Location',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              widget.pickupLocation, // Data dari BookCarPage
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      const Text('Payment',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10.0),
                      const Row(
                        children: [
                          Icon(Icons.credit_card),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MasterCard',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('**** **** 1234 5678'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(350, 40),
                            backgroundColor:
                                const Color.fromRGBO(127, 90, 240, 1),
                          ),
                          onPressed: () {
                            // Tambahkan fungsionalitas booking
                          },
                          child: const Text('Booking'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
