import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/component/form_component.dart';
import 'package:pbp_widget_a_klmpk4/view/login/login.dart';
// import 'package:pbp_widget_a_klmpk4/database/sql_helper_user.dart';
import 'package:pbp_widget_a_klmpk4/entity/user.dart';
import 'package:pbp_widget_a_klmpk4/client/UserClient.dart';
import 'package:pbp_widget_a_klmpk4/theme.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  final int userId;
  const ChangePassword({required this.userId, super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  Map<String, dynamic> userData = {};
  TextEditingController passwordController = TextEditingController();
  void takeUser() async {
    UserClient.find(widget.userId).then((userDataFromDatabase) {
      setState(() {
        userData = userDataFromDatabase.toJson();
      });
    });
  }

  @override
  void initState() {
    takeUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(7.0.w),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Masukan Password Baru Anda',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              inputForm(
                (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Password kosong';
                  }
                  if (p0.length < 5) {
                    return 'Password minimal 5 digit';
                  }
                  return null;
                },
                password: true,
                controller: passwordController,
                hintTxt: 'Password',
                helperTxt: '',
                iconData: Icons.lock,
              ),
              ElevatedButton(
                onPressed: () async {
                  final newUser = User(
                    id: widget.userId,
                    username: userData['username'],
                    email: userData['email'],
                    password: passwordController.text,
                    noTelp: userData['noTelp'],
                    tglLahir: userData['tglLahir'],
                    image: userData['image'],
                  );

                  UserClient.update(newUser);

                  Map<String, dynamic> formData = {
                    'username': userData['username'],
                    'password': passwordController.text,
                  };

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Update Password Berhasil'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigate to the login view
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginView(data: formData),
                              ),
                            );
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Perbarui'),
              ),
            ]),
      )),
    );
  }
}
