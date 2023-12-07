import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
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
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 40.0), 
                ],
              ),
              SizedBox(height: 20.0),
              buildContactCard(
                'E-mail',
                'cs@carrent.com',
                Icons.email,
                () => _launchEmail('cs@carrent.com'),
              ),
              buildContactCard(
                'Call-center',
                '+21-0274-1234',
                Icons.phone,
                () => _launchPhone('+2102741234'),
              ),
              buildContactCard(
                'WhatsApp',
                '+62-8123-4567',
                Icons.chat,
                () => _launchWhatsApp('+6281234567'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContactCard(String title, String detail, IconData icon, Function() onTap) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      elevation: 2.0,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(detail),
            SizedBox(height: 5),
            GestureDetector(
              onTap: onTap,
              child: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuka aplikasi email
  void _launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    String urlString = _emailLaunchUri.toString();
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch $urlString';
    }
  }

  // Fungsi untuk membuka aplikasi telepon
  void _launchPhone(String phone) async {
    final Uri _phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    String urlString = _phoneLaunchUri.toString();
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch $urlString';
    }
  }

  // Fungsi untuk membuka aplikasi WhatsApp
  void _launchWhatsApp(String phone) async {
    final Uri _whatsappLaunchUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phone,
    );
    String urlString = _whatsappLaunchUri.toString();
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}
