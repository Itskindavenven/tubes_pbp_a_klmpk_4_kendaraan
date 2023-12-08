import 'package:flutter/material.dart';

class FriendListPage extends StatefulWidget {
  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                      Navigator.pop(context);
                    },
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Friends',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman Add Friend
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddFriendPage()));
              },
              child: const Text('ADD FRIENDS'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              buildFriendCard('assets/images/gojohh.jpg', 'My Wife',
                  'heheehehe, sun is light'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFriendCard(String imagePath, String name, String description) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
      ),
    );
  }
}

class AddFriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friend'),
      ),
      body: const Center(
        child: Text('Add Friend Page'),
      ),
    );
  }
}