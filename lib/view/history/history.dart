import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/history/review.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isReviewed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Center(
                    child: Text(
                      'HISTORY PAYMENT',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 40.0),
                ],
              ),
              const SizedBox(height: 20.0),
              buildPaymentCard(
                  'Porsche GT3RS', '20/11/2023', 'Rp 540.000,00', 'dn129he9'),
              const SizedBox(height: 16.0),
              buildPaymentCard('Pajero Sport 2019', '20/11/2023',
                  'Rp 540.000,00', 'wjdia2992'),
              const SizedBox(height: 16.0),
              buildPaymentCard('Pajero Sport 2019', '20/11/2023',
                  'Rp 540.000,00', 'wjdia2992'),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentCard(String title, String date, String price, String id) {
    return Card(
      elevation: 3,
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
                  title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(30, 25),
                    backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ReviewPage()),
                    );
                  },
                  child: const Text(
                    'Done',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8.0),
                Text('ID: $id'),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(50, 20),
                        backgroundColor: Colors.white,
                        side:
                            BorderSide(color: Color.fromRGBO(127, 90, 240, 1)),
                      ),
                      onPressed: () {
                        setState(() {
                          isReviewed = !isReviewed;
                        });
                      },
                      child: isReviewed
                          ? Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Color.fromRGBO(127, 90, 240, 1)),
                                const SizedBox(width: 3),
                                Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 33, 206, 1),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        iconSize: 12,
                                        onPressed: () {
                                          // Tambahkan logika saat tombol edit ditekan
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                    )),
                                const SizedBox(width: 3),
                                Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(216, 0, 39, 1),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        iconSize: 12,
                                        onPressed: () {
                                          // Tambahkan logika saat tombol hapus ditekan
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    )),
                              ],
                            )
                          : Text(
                              'Review',
                              style: TextStyle(
                                  color: Color.fromRGBO(127, 90, 240, 1)),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
