import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/payment/payment.dart';

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryMonthController = TextEditingController();
  TextEditingController _expiryYearController = TextEditingController();
  TextEditingController _cnnController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryMonthController.dispose();
    _expiryYearController.dispose();
    _cnnController.dispose();
    super.dispose();
  }

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
                        MaterialPageRoute(builder: (context) => PaymentPage()),
                      );
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Add Card',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 40.0),
                ],
              ),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  width: 350,
                  height: 200,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                  'Add credit card',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              SizedBox(height: 20.0),
              buildTextField('Credit card number', _cardNumberController),
              buildTextField('Expiry Month', _expiryMonthController),
              buildTextField('Expiry Year', _expiryYearController),
              buildTextField('CNN', _cnnController),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentPage()),
                      );
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
