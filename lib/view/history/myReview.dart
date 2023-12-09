import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbp_widget_a_klmpk4/entity/review.dart';
import 'package:pbp_widget_a_klmpk4/client/reviewClient.dart';
// import 'package:pbp_widget_a_klmpk4/entity/user.dart';
import 'package:pbp_widget_a_klmpk4/client/userClient.dart';
import 'package:pbp_widget_a_klmpk4/client/carClient.dart';
import 'package:pbp_widget_a_klmpk4/entity/car.dart';
import 'package:pbp_widget_a_klmpk4/view/history/addReview.dart';
import 'package:pbp_widget_a_klmpk4/view/history/editReview.dart';
// import 'package:pbp_widget_a_klmpk4/view/history/history.dart';
import 'package:pbp_widget_a_klmpk4/view/home/home.dart';
// import 'package:pbp_widget_a_klmpk4/view/history/editReview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyReviewPage extends StatefulWidget {
  const MyReviewPage({Key? key}) : super(key: key);

  @override
  State<MyReviewPage> createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage> {
  Map<String, dynamic>? userData;
  List<Review> reviewData = [];
  List<Car> carData = [];

  void showMyReview(int userId) async {
    try {
      List<Review> data = await reviewClient.fetchAllByUser(userId);
      List<Car> dataCar = await CarClient.fetchAll();
      print('Data before processing: $data');
      print('Data before car processing: $dataCar');
      setState(() {
        reviewData = data;
        carData = dataCar;
      });
    } catch (e) {
      print('Error during data processing: $e');
    }
  }

  Future<void> deleteReview(int reviewId) async {
    await reviewClient.destroy(reviewId);
    showMyReview(userData?['id']);
  }

  Future<void> takeUser() async {
    int userId;
    userId = await getPrefsId();
    UserClient.find(userId).then((userDataFromDatabase) {
      print("Response from server: $userDataFromDatabase");
      setState(() {
        userData = userDataFromDatabase.toJson();
        showMyReview(userId);
        print(userData);
      });
    });
  }

  getPrefsId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = await prefs.getInt('userId') ?? 0;
    return id;
  }

  void clearPrefsId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
  }

  @override
  void initState() {
    print("User: $userData");
    takeUser();
    // showMyReview(userData?['id']);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Homepage(),
                              ));
                        },
                      ),
                      const Text(
                        '',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Center(
                    child: Text(
                      'My Car REVIEW',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 90.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Homepage()),
                      );
                    },
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(127, 90, 240, 1)),
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
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Update',
                          color: Colors.blue,
                          icon: Icons.edit,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditReviewPage(
                                        initialReview: review,
                                      )),
                            );
                          },
                        ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            print(review.id);
                            print(userData?['id']);
                            await deleteReview(review.id!);
                            showMyReview(userData?['id']);
                          },
                        ),
                      ],
                      child: buildPaymentCard(review),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddReviewPage()),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
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
                  userData?['username'],
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
