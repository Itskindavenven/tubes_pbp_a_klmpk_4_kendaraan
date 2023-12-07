import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/history/history.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int selectedStarIndex = -1;
  TextEditingController commentController = TextEditingController();

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'GR YARIS',
                    style: TextStyle(fontSize: 24),
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
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Toyota',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
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
                  SizedBox(height: 20),
                  Text(
                    'Write your Comment',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
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
                  minimumSize: Size(100, 50),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPage()),
                  );
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color.fromRGBO(127, 90, 240, 1)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 50),
                  backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPage()),
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
