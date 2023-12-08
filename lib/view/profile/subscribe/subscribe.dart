import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/client/SubsClient.dart';
import 'package:pbp_widget_a_klmpk4/entity/subs.dart';
import 'package:pbp_widget_a_klmpk4/view/home/home.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/subscribe/paket.dart';

class SubscribePage extends StatefulWidget {
  final int userId;

  const SubscribePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  String? subscriptionType = 'FREE';
  late Subscription data;

  Future<void> fetchData(int userId) async {
    try {
      Subscription subscription = await SubsClient.find(userId);
      print("subs disini!!!$subscription");
      setState(() {
        data = subscription;
        subscriptionType = subscription.tipe;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    fetchData(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homepage()),
                        );
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      'SUBSCRIBE',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40.0),
                  ],
                ),
                const SizedBox(height: 20.0),

                subscriptionType != "FREE"
                    ? const CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            AssetImage('assets/images/checkmark.png'),
                      )
                    : const CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('assets/images/free.png'),
                      ),

                const SizedBox(height: 20.0),
                // Teks berdasarkan jenis langganan
                Text(
                  'Your Account Type is $subscriptionType',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),

                subscriptionType == "FREE"
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(127, 90, 240, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaketPage(
                                      userId: widget.userId,
                                    )),
                          );
                        },
                        child: const Text('MULAI'),
                      )
                    : const SizedBox(),

                subscriptionType != "FREE"
                    ? Card(
                        elevation: 4.0,
                        child: ClipRect(
                          child: Stack(
                            children: [
                              Container(
                                color: _getColorForSubscriptionType(
                                    data.tipe ?? 'FREE'),
                                height: 70,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.tipe ?? 'gada',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      data.harga.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Divider(color: Colors.grey),
                                    const SizedBox(height: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: data.deskripsi != null
                                          ? data.deskripsi!
                                              .split('\n')
                                              .map((line) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.check,
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
                                              );
                                            }).toList()
                                          : [],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0), // Tambahkan padding di atas
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subscriptionType != "FREE"
                          ? Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromRGBO(127, 90, 240, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PaketPage(userId: widget.userId),
                                    ),
                                  );
                                },
                                child: const Text('Update'),
                              ),
                            )
                          : const SizedBox(),
                      subscriptionType != "FREE"
                          ? const SizedBox(width: 10)
                          : const SizedBox(),
                      subscriptionType != "FREE"
                          ? Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromRGBO(127, 90, 240, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () async {
                                  deleteSubscription(data.id!);
                                },
                                child: const Text('Delete'),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
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

  void showSnackBar(BuildContext context, String msg, Color bg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
          label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }

  void deleteSubscription(int id) async {
    try {
      print("test ${data.id}");
      await SubsClient.destroy(id);
      showSnackBar(context, "Berhasil Hapus Subscribe", Colors.green);

      setState(() {
        subscriptionType = "FREE";
      });
    } catch (e) {
      print('Error deleting: $e');
    }
  }
}
