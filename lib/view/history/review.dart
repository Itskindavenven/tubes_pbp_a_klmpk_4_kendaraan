import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/entity/cart.dart';
import 'package:pbp_widget_a_klmpk4/entity/car.dart';
// import 'package:pbp_widget_a_klmpk4/view/history/history.dart';
import 'package:pbp_widget_a_klmpk4/view/home/home.dart';
import 'package:pbp_widget_a_klmpk4/entity/rating.dart';
import 'package:pbp_widget_a_klmpk4/client/ratingClient.dart';
import 'package:pbp_widget_a_klmpk4/client/carClient.dart';
import 'package:pbp_widget_a_klmpk4/client/cartClient.dart';

class ReviewPage extends StatefulWidget {
  final Cart selectedCart;
  ReviewPage({Key? key, required this.selectedCart}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int selectedStarIndex = -1;
  TextEditingController commentController = TextEditingController();
  Car selectedCar = Car(
      id_car: 0,
      nama: '',
      merk: '',
      max_power: '',
      fuel: 0,
      transmisi: '',
      max_speed: '',
      kursi: 0,
      gps: 0,
      bluetooth: 0,
      harga: 0,
      image_car: '');

  Future<void> saveReview() async {
    int idCar = widget.selectedCart.id_car ?? 0;
    String deskripsi = commentController.text;
    int bintang = selectedStarIndex + 1;

    Rating newRating =
        Rating(id_car: idCar, deskripsi: deskripsi, bintang: bintang);

    try {
      var response = await ratingClient.create(newRating);

      if (response.statusCode == 201) {
        await CartClient.updateIsReviewed(widget.selectedCart.id ?? 0);
      } else {
        print('Failed to save review: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error saving review: $e');
    }
  }

  Future<void> fetchCarData() async {
    Car car = await CarClient.fetch(widget.selectedCart.id_car);
    setState(() {
      selectedCar = car;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.selectedCart.id_car != null) {
      fetchCarData();
    } else {
      print('Error: widget.selectedCart.id_car is null.');
    }
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedCar.nama ?? 'default name car',
                    style: TextStyle(fontSize: 24),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20.0,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '4.8',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
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
                  Text(
                    selectedCar.merk ?? 'default car merk',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/car1.jpeg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    'Quality of the car',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            selectedStarIndex = index;
                          });
                        },
                        icon: Icon(
                          Icons.star,
                          color: index <= selectedStarIndex
                              ? Colors.yellow
                              : Colors.grey,
                          size: 30.0,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Write your Comment',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your comment here',
                    ),
                    maxLines: 3,
                  ),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color.fromRGBO(127, 90, 240, 1)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                ),
                onPressed: () async {
                  await saveReview();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
