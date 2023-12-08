import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_widget_a_klmpk4/client/userClient.dart';
import 'package:pbp_widget_a_klmpk4/entity/user.dart';
import 'package:pbp_widget_a_klmpk4/view/profile/notification.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController dobController;
  late TextEditingController noTelpController;
  bool _isPasswordVisible = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    DateTime? selectedDate;
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (picked.isAfter(currentDate)) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Tanggal lahir tidak boleh lebih dari tanggal hari ini.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          selectedDate = picked;
          dobController.text =
              "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    usernameController =
        TextEditingController(text: widget.userData['username']);
    passwordController =
        TextEditingController(text: widget.userData['password']);
    emailController = TextEditingController(text: widget.userData['email']);
    dobController = TextEditingController(text: widget.userData['tglLahir']);
    noTelpController = TextEditingController(text: widget.userData['noTelp']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage()),
                      );
                    },
                    child: const Icon(Icons.notifications),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              const Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/gojohh.jpg'),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Hello',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Joined at today',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                child: const Text(
                  'Profile Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Username",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      TextFormField(
                        key: const Key("Username"),
                        controller: usernameController,
                        style: const TextStyle(fontSize: 14),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username Tidak Boleh Kosong';
                          }
                          if (value.length < 5) {
                            return 'Username Tidak Boleh Kurang dari 5 karakter';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      TextFormField(
                        key: const Key("Password"),
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "password kosong";
                          }
                          if (value.length < 5) {
                            return 'Password minimal 5 digit';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(fontSize: 14),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email Tidak Boleh Kosong';
                          }
                          if (!value.contains('@')) {
                            return 'Email harus menggunakan @';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Date of Birth',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      TextFormField(
                        controller: dobController,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal Lahir Tidak Boleh Kosong';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      TextFormField(
                        controller: noTelpController,
                        style: const TextStyle(fontSize: 14),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomor Telepon Tidak Boleh Kosong';
                          }
                          if (value.length < 11) {
                            return 'Nomor Telepon minimal 11 digit';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  updateProfile();
                },
                child: const Text('Update profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // String formatDateTime(Timestamp? timestamp) {
  //   if (timestamp == null) {
  //     return ''; // Handle null case as needed
  //   }
  //   return DateFormat.yMMMM('en_US').format(timestamp.toDate());
  // }

  Widget buildEditableCard(String title, TextEditingController controller) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            TextField(
              controller: controller,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile() async {
    User updatedUser = User(
      id: widget.userData['id'],
      username: usernameController.text,
      email: emailController.text,
      password: widget.userData['password'],
      tglLahir: dobController.text,
      noTelp: noTelpController.text,
      // updated_at: Timestamp.now(),
    );

    try {
      await UserClient.update(updatedUser);
      print('Message Updated');
    } catch (e) {
      print('Error Updating Message : $e');
    }
  }
}