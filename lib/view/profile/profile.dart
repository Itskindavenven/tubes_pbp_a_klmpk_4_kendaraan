import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/login/login.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/contactUs.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/friendList.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/payment/payment.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/editProfile.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/notification.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/promo.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/settings/settings.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Location',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Yogyakarta',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/gojohh.jpg'),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Gojo Satoru',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 8.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfilePage()),
                      );
                },
                child: Center(
                  child: Text(
                    'View and Edit Profile',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildCard(
                    icon: Icons.bookmark,
                    title: 'BOOKMARKS',
                    onTap: () {
                      // Navigate to bookmarks page
                    },
                  ),
                  buildCard(
                    icon: Icons.qr_code,
                    title: 'SCAN QR',
                    onTap: () {
                      // Navigate to scan QR page
                    },
                  ),
                  buildCard(
                    icon: Icons.settings,
                    title: 'SETTINGS',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.history,
                    title: 'HISTORY',
                    onTap: () {
                      // Navigate to history page
                    },
                  ),
                  buildCard(
                    icon: Icons.payment,
                    title: 'PAYMENT',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.bookmark,
                    title: 'PROMOS',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PromoPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.group,
                    title: 'FRIENDS LIST',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => FriendListPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.chat,
                    title: 'CONTACT US',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ContactUsPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.exit_to_app,
                    title: 'SIGN OUT',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    },
                  ),
                ],
              ),
              Spacer(),
              BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.directions_car),
                    label: 'Bookings',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(height: 4.0),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
