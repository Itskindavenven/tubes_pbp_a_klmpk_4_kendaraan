import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/entity/user.dart';
import 'package:pbp_widget_a_klmpk4/view/history/review.dart';
import 'package:pbp_widget_a_klmpk4/client/ReviewClient.dart';
import 'package:pbp_widget_a_klmpk4/entity/review.dart';
import 'package:pbp_widget_a_klmpk4/entity/car.dart';
import 'package:pbp_widget_a_klmpk4/client/UserClient.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isReviewed = false;

  List<Review> review = [];
  void refresh() async {
    List<Review> data = await ReviewClient.fetchAll();
    if (data == null || data.isEmpty) {
      Icons.local_grocery_store_sharp;
      print('Review empty');
    } else {
      setState(() {
        review = data;
      });
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Review',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(127, 90, 240, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewPage(),
                        ),
                      );
                    },
                    child: const Text('Review'),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: review.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<Car>(
                                future: ReviewClient.getDataCar(
                                    review[index].id_car!),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Car> snapshot) {
                                  if (snapshot.hasData) {
                                    return Text("${snapshot.data!.nama}",
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ));
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold));
                                  }
                                  // By default, show a loading spinner.
                                  return CircularProgressIndicator();
                                },
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder<User>(
                                    future:
                                        UserClient.find(review[index].id_user),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<User> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                            "${snapshot.data!.username}",
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ));
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold));
                                      }
                                      // By default, show a loading spinner.
                                      return CircularProgressIndicator();
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${review[index].deskripsi}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal)),
                                  ]),
                            ]),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentCard(String title, String comment, String username) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$username = $comment',
                  style: TextStyle(fontSize: 18),
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
