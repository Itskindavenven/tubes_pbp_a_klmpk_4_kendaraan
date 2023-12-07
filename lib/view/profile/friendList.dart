import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/profile.dart';

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Icon(Icons.arrow_back),
            ),
            SizedBox(width: 8.0),
            Text(
              'Friends',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman Add Friend
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddFriendPage()));
              },
              child: Text('ADD FRIENDS'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              SizedBox(height: 20.0),
              buildFriendCard('assets/my_wife_image.jpg', 'My Wife',
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
          style: TextStyle(
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
        title: Text('Add Friend'),
      ),
      body: Center(
        child: Text('Add Friend Page'),
      ),
    );
  }
}
