import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/settings/settings.dart';

class LanguagePage extends StatelessWidget {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              buildLanguageCard('English', 'US', context),
              buildLanguageCard('Indonesia', 'ID', context),
              buildLanguageCard('日本語', 'JP', context),
              buildLanguageCard('中文', 'CN', context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLanguageCard(
      String language, String countryCode, BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      elevation: 2.0,
      child: ListTile(
        title: Text(language),
        trailing: Image.asset(
          'assets/flags/$countryCode.png', // Ganti dengan path gambar bendera yang sesuai
          width: 40.0,
          height: 40.0,
          fit: BoxFit.cover,
        ),
        onTap: () {
          // Tambahkan logika pemilihan bahasa di sini, misalnya dengan menyimpan preferensi bahasa
          // atau melakukan navigasi kembali ke halaman sebelumnya dengan membawa data bahasa yang dipilih
          Navigator.pop(context, language);
        },
      ),
    );
  }
}
