import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/payment/addCard.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/profile.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Payment',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 40.0),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Payment Options',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              buildCard('MasterCard', '**** **** 1234 5678', Icons.credit_card),
              SizedBox(height: 20.0),
              buildAddCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String cardType, String cardNumber, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      elevation: 2.0,
      child: ListTile(
        leading: Icon(icon),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardType,
              style: TextStyle(
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
      margin: EdgeInsets.only(bottom: 16.0),
      elevation: 2.0,
      child: ListTile(
        leading: Icon(Icons.add),
        title: Text(
          'Add credit/debit card',
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddCardPage()),
          );
        },
      ),
    );
  }
}
