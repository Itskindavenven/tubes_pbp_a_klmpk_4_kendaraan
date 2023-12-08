import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/client/userClient.dart';
import 'package:pbp_widget_a_klmpk4/entity/review.dart';
import 'package:pbp_widget_a_klmpk4/client/reviewClient.dart';
import 'package:pbp_widget_a_klmpk4/entity/user.dart';
import 'package:pbp_widget_a_klmpk4/entity/car.dart';
import 'package:pbp_widget_a_klmpk4/client/carClient.dart';
import 'package:pbp_widget_a_klmpk4/view/history/myReview.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isReviewed = false;
  List<Review> reviewData = [];
  List<Car> carData = [];
  List<User> userData = [];
  // Car cart = Car();
  // User user = User();

  void showReview() async {
    try {
      List<Review> data = await reviewClient.fetchAll();
      print('Data before processing: $data');

      List<Car> dataCar = await CarClient.fetchAll();
      print("aman");
      List<User> dataUser = await UserClient.fetchAll();
      print("aman 2");

      setState(() {
        reviewData = data;
        carData = dataCar;
        userData = dataUser;
      });

      print('Data after processing: $reviewData');
    } catch (e) {
      print('Error during data processing: $e');
    }
  }

  void initState() {
    showReview();
    super.initState();
  }

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
                children: [
                  const Center(
                    child: Text(
                      'CARS REVIEW',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 100.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyReviewPage()),
                      );
                    },
                    child: const Text(
                      'My Review',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(127, 90, 240, 1)
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Expanded(
                // child: buildPaymentCard(reviewData[0]),
                child: ListView.builder(
                  itemCount: reviewData.length,
                  itemBuilder: (context, index) {
                    Review review = reviewData[index];
                    return buildPaymentCard(review);
                  },
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentCard(Review review) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  carData
                      .where((element) => element.id_car == review.id_car)
                      .first
                      .nama!,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userData
                      .where((element) => element.id == review.id_user)
                      .first
                      .username!,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8.0),
                Text('RATING: ${review.nilai}'),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.komentar!,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}