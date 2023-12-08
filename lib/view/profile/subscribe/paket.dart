import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/client/SubsClient.dart';
import 'package:pbp_widget_a_klmpk4/entity/subs.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/subscribe/subscribe.dart';

class PaketPage extends StatefulWidget {
  final int userId;
  const PaketPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<PaketPage> createState() => _PaketPageState();
}

class _PaketPageState extends State<PaketPage> {
  late Subscription data;
  int? idSubs;
  bool isLoading = false;

  Future<void> fetchData(int userId) async {
    print("Ini user $userId");
    try {
      Subscription subscription = await SubsClient.find(userId);
      print("subs disini!!!$subscription");
      setState(() {
        data = subscription;
        idSubs = subscription.id;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    fetchData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubscribePage(
                              userId: widget.userId,
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      'SUBSCRIBES',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40.0),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSubscriptionCard(
                  'Bronze',
                  'Rp 100.000/bulan',
                  'Layanan pelanggan standar\nDiskon 5% untuk setiap penyewaan',
                  Icons.check,
                ),
                const SizedBox(height: 20),
                _buildSubscriptionCard(
                  'Silver',
                  'Rp 200.000/bulan',
                  'Layanan pelanggan prioritas 24/7\nDiskon 10% untuk setiap penyewaan',
                  Icons.check,
                ),
                const SizedBox(height: 20),
                _buildSubscriptionCard(
                  'Gold',
                  'Rp 300.000/bulan',
                  'Layanan pelanggan VIP 24/7 dengan asisten pribadi\nDiskon 20% untuk setiap penyewaan\nAsuransi lengkap untuk keamanan tambahan',
                  Icons.check,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(
      String title, String price, String description, IconData iconData) {
    List<String> descriptionLines = description.split('\n');

    return Card(
      elevation: 4.0,
      child: ClipRect(
        child: Stack(
          children: [
            Container(
              color: _getColorForSubscriptionType(title),
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: descriptionLines
                        .map(
                          (line) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Icon(
                                  iconData,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    line,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          double maxHeight =
                              MediaQuery.of(context).size.height * 0.60;

                          return Container(
                            constraints: BoxConstraints(
                              maxHeight: maxHeight,
                            ),
                            child: buildCombinedBottomSheet(
                                title, widget.userId, idSubs),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(127, 90, 240, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Mulai'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForSubscriptionType(String subscriptionType) {
    switch (subscriptionType) {
      case 'Bronze':
        return Colors.brown;
      case 'Silver':
        return Colors.grey;
      case 'Gold':
        return Colors.amber;
      default:
        return Colors.transparent;
    }
  }

  Widget buildSpecCard(IconData icon, String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCombinedBottomSheet(
      String subscriptionType, int idUser, int? idSubs) {
    String subsName = '';
    String subsPrice = '';
    String description = '';

    switch (subscriptionType) {
      case 'Bronze':
        subsName = 'Bronze';
        subsPrice = '100000';
        description =
            'Layanan pelanggan standar,\nDiskon 5% untuk setiap penyewaan';
        break;
      case 'Silver':
        subsName = 'Silver';
        subsPrice = '200000';
        description =
            'Layanan pelanggan prioritas 24/7,\nDiskon 10% untuk setiap penyewaan.';
        break;
      case 'Gold':
        subsName = 'Gold';
        subsPrice = '300000';
        description =
            'Layanan pelanggan VIP 24/7 dengan sopir,\nDiskon 20% untuk setiap penyewaan,\nAsuransi lengkap untuk keamanan tambahan.';
        break;
      default:
        subsName = 'Tipe paket tidak tersedia';
        subsPrice = 'Harga tidak tersedia';
        description = 'Deskripsi tidak tersedia';
    }
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(127, 90, 240, 1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subsName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        subsPrice,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            // color: Colors.grey,
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Overview',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(Icons.check),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Benefit:'),
                          Text(description),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Payment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              buildSpecCard(
                Icons.credit_card,
                'MasterCard',
                '**** **** 1234 5678',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                        fixedSize: const Size(100, 30)),
                    onPressed: () async {
                      print('asdasd $idSubs');
                      try {
                        Subscription subscription;
                        if (idSubs != null) {
                          subscription = Subscription(
                            id: idSubs,
                            idUser: idUser,
                            tipe: subsName,
                            harga: int.parse(subsPrice),
                            deskripsi: description,
                          );
                          await SubsClient.update(subscription);
                        } else {
                          subscription = Subscription(
                            idUser: idUser,
                            tipe: subsName,
                            harga: int.parse(subsPrice),
                            deskripsi: description,
                          );
                          await SubsClient.create(subscription);
                        }
                      } catch (e) {
                        print(
                            'Error adding or updating subscription: $e $idSubs');
                      }

                      // ignore: use_build_context_synchronously
                      showSnackBar(context,
                          "Pembelian Paket $subsName Berhasil!", Colors.green);

                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SubscribePage(userId: idUser)),
                      );
                    },
                    child: const Text('Beli'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showSnackBar(BuildContext context, String msg, Color bg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
          label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
