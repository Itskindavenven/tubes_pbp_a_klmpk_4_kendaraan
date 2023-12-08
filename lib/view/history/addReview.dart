import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbp_widget_a_klmpk4/entity/review.dart';
import 'package:pbp_widget_a_klmpk4/client/reviewClient.dart';
// import 'package:pbp_widget_a_klmpk4/entity/user.dart';
import 'package:pbp_widget_a_klmpk4/client/userClient.dart';
import 'package:pbp_widget_a_klmpk4/client/carClient.dart';
import 'package:pbp_widget_a_klmpk4/entity/car.dart';
// import 'package:pbp_widget_a_klmpk4/view/history/history.dart';
import 'package:pbp_widget_a_klmpk4/view/home/home.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({Key? key}) : super(key: key);

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  Map<String, dynamic>? userData;
  Car? _selectedCar;
  TextEditingController nilaiController = TextEditingController();
  TextEditingController komentarController = TextEditingController();
  List<Car> carData = [];

  void showCar() async {
    try {
      List<Car> data = await CarClient.fetchAll();
      setState(() {
        carData = data;
      });
    } catch (e) {
      print('Error during data processing: $e');
    }
  }

  @override
  void dispose() {
    nilaiController.dispose();
    komentarController.dispose();
    super.dispose();
  }

  Future<void> takeUser() async {
    int userId;
    userId = await getPrefsId();
    UserClient.find(userId).then((userDataFromDatabase) {
      print("Response from server: $userDataFromDatabase");
      setState(() {
        userData = userDataFromDatabase.toJson();
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

  void initState() {
    showCar();
    takeUser();
    super.initState();
  }

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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Homepage()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Car',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<Car>(
                    value: _selectedCar,
                    onChanged: (Car? newValue) {
                      setState(() {
                        _selectedCar = newValue;
                      });
                    },
                    items: carData.map((Car car) {
                      return DropdownMenuItem<Car>(
                        value: car,
                        child: Text(car.nama!),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nilai Rating',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    controller: nilaiController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Nilai mu',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Komentar',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    controller: komentarController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Komentar mu',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 100.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(450, 40),
                    backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                  ),
                  onPressed: () async {
                    if (_selectedCar != null) {
                      int selectedCarId = _selectedCar!.id_car ?? 0;
                      int nilai = int.parse(nilaiController.text);
                      int selectedUserId = userData?['id'] ?? 0;
                      print(selectedUserId);

                      Review newReview = Review(
                        id_user: selectedUserId,
                        id_car: selectedCarId,
                        nilai: nilai,
                        komentar: komentarController.text,
                        // Exclude updated_at and created_at from the object
                      );
                      try {
                        await reviewClient.create(newReview);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Homepage(),
                          ),
                        );
                      } catch (e) {
                        // Handle the error (e.g., display an error message)
                        print('Error creating review: $e');
                      }
                    }
                  },
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}