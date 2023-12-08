import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/payment/addCard.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    'Payment',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40.0),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Payment Options',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              buildCard('MasterCard', '**** **** 1234 5678', Icons.credit_card),
              const SizedBox(height: 20.0),
              buildAddCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String cardType, String cardNumber, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2.0,
      child: ListTile(
        leading: Icon(icon),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardType,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(cardNumber),
          ],
        ),
      ),
    );
  }

  Widget buildAddCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2.0,
      child: ListTile(
        leading: const Icon(Icons.add),
        title: const Text(
          'Add credit/debit card',
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCardPage()),
          );
        },
      ),
    );
  }
}