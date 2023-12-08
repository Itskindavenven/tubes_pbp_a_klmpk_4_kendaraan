import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbp_widget_a_klmpk4/client/userClient.dart';
import 'package:pbp_widget_a_klmpk4/entity/user.dart';
import 'package:pbp_widget_a_klmpk4/view/login/login.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Please input your email to recover your CAR RENT account',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                  ),
                  onPressed: () {
                    // Navigate to Create New Password Page with email data
                    if (_formKey.currentState!.validate()) {
                      UserClient.validasi(emailController.text)
                          .then((value) async {
                        // ignore: unnecessary_null_comparison
                        if (value != null) {
                          showSnackBar(
                              context, "Validasi Sukses", Colors.green);
                          int? userId = value.id;
                          if (userId != null) {
                            addPrefsId(userId);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CreateNewPasswordPage(userId: userId),
                              ),
                            );
                          }
                        } else {
                          showSnackBar(context, "Validasi gagal", Colors.red);
                        }
                      }).catchError((error) {
                        showSnackBar(context, "Validasi gagal", Colors.red);
                      });
                    }
                  },
                  child: const Text('Recover Account'),
                ),
              ],
            ),
          ),
        ));
  }
}

addPrefsId(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('userId', id);
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: bg,
    action:
        SnackBarAction(label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
  ));
}

class CreateNewPasswordPage extends StatefulWidget {
  final int userId;

  const CreateNewPasswordPage({Key? key, required this.userId})
      : super(key: key);

  @override
  _CreateNewPasswordPageState createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  Map<String, dynamic> userData = {};
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to Forgot Password Page
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Create New Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please create a new password for your CAR RENT account to access your account again',
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password kosong';
                }
                if (value.length < 5) {
                  return 'Password minimal 5 digit';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: retypePasswordController,
              decoration: const InputDecoration(
                labelText: 'Retype Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password kosong';
                }
                if (value.length < 5) {
                  return 'Password minimal 5 digit';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
              ),
              onPressed: () async {
                // Validate and change password logic
                if (passwordController.text.isEmpty ||
                    retypePasswordController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content:
                            const Text('Please fill in both password fields.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                color: Color.fromRGBO(127, 90, 240, 1),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (passwordController.text !=
                    retypePasswordController.text) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Passwords do not match.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  final newUser = User(
                    id: widget.userId,
                    username: userData['username'],
                    email: userData['email'],
                    password: passwordController.text,
                    noTelp: userData['noTelp'],
                    tglLahir: userData['tglLahir'],
                    image: userData['image'],
                  );
                  await UserClient.update(newUser);

                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text(
                            'Your password has been changed. Please retry to Login Again!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Confirm Password'),
            ),
          ],
        ),
      ),
    );
  }
}
