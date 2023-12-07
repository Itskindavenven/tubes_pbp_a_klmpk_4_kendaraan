import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/notification.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/profile.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
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
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NotificationPage()),
                      );
                    },
                    child: Icon(Icons.notifications),
                  )
                ],
              ),
              SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/gojohh.jpg'),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Gojo Satoru',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Joined at October 2023',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                child:
                Text(
                  'Profile Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                ),
              ),
              SizedBox(height: 8.0),
              buildEditableCard('Email', 'gojosatorukeren@gmail.com'),
              buildEditableCard('Date of Birth', '2 Desember 1989'),
              buildEditableCard('Phone Number', '000000000000'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableCard(String title, String content) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              content,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
