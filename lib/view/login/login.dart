import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbp_widget_a_klmpk4/entity/user.dart';
import 'package:pbp_widget_a_klmpk4/view/login/forgot_password.dart';
import 'package:pbp_widget_a_klmpk4/view/home/home.dart';
import 'package:pbp_widget_a_klmpk4/view/login/register.dart';
import 'package:pbp_widget_a_klmpk4/client/userClient.dart';

class LoginPage extends StatefulWidget {
  final Map? data;

  const LoginPage({Key? key, this.data}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Check if registration was successful
    if (widget.data != null && widget.data!['registrationSuccess'] == true) {
      // Show a SnackBar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSnackBar(context, "Register Berhasil!", Colors.green);
      });
    }

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(127, 90, 240, 1),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                    labelText: 'Username', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username Tidak Boleh Kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "password kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPass()),
                      );
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Color.fromRGBO(127, 90, 240, 1)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      User? loggedUser = await UserClient.login(
                          usernameController.text, passwordController.text);
                      if (loggedUser != null) {
                        print(loggedUser.id);
                        // ignore: use_build_context_synchronously
                        addPrefsId(loggedUser.id);
                        showSnackBar(context, "Login Berhasil!", Colors.green);
                        await Future.delayed(const Duration(seconds: 2));
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homepage()),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        showSnackBar(context, "Username atau Password Salah!",
                            Colors.red);
                      }
                    } catch (e) {
                      showSnackBar(
                          context, "Username atau Password Salah!", Colors.red);
                    }
                  }
                },
                child: const Text(
                  'Login',
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account? '),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color.fromRGBO(127, 90, 240, 1),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
      print(_isPasswordVisible);
    });
  }

  addPrefsId(int? id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', id ?? 0);
  }

  // void showToast(String msg, Color color) {
  //   Fluttertoast.showToast(
  //       msg: msg,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.TOP,
  //       backgroundColor: color,
  //       textColor: Colors.white,
  //       fontSize: 18,
  //       timeInSecForIosWeb: 2);
  // }

  void showSnackBar(BuildContext context, String msg, Color bg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
          label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
