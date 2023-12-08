import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Center(
                child: Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
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
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2.0,
      child: ListTile(
        title: Text(language),
        trailing: Image.asset(
          'assets/flags/$countryCode.png',
          width: 40.0,
          height: 40.0,
          fit: BoxFit.cover,
        ),
        onTap: () {
          Navigator.pop(context, language);
        },
      ),
    );
  }
}