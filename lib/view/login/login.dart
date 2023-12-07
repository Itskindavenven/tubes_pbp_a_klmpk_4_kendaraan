import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pbp_widget_a_klmpk4/view/home/home.dart';
import 'package:pbp_widget_a_klmpk4/view/login/register.dart';
import 'package:pbp_widget_a_klmpk4/client/UserClient.dart';
import 'package:pbp_widget_a_klmpk4/component/form_component.dart';
import 'package:pbp_widget_a_klmpk4/view/login/forgot_password.dart';
import 'package:pbp_widget_a_klmpk4/entity/user.dart';
import 'package:pbp_widget_a_klmpk4/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pbp_widget_a_klmpk4/entity/user.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({Key? key, this.data}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Map? dataForm = widget.data;
    // if (widget.data != null && widget.data!['registrationSuccess'] == true) {
    //   // Show a SnackBar
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text('Registration successful! Please log in.'),
    //       ),
    //     );
    //   });
    // }

    // Gunakan tema sesuai dengan kondisi _isDarkTheme
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.isDarkTheme ? darkTheme : lightTheme;

    return MaterialApp(
      theme: theme, // Terapkan tema ke MaterialApp
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent[400],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),

                      // Input field untuk username
                      inputForm(
                        // style: TextStyle(color: Colors.deepPurpleAccent),
                        (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "Username Should Not Empty !";
                          }
                          return null;
                        },
                        controller: usernameController,
                        hintTxt: "Username",
                        helperTxt: "",
                        iconData: Icons.person,
                        suffixIcon: null,
                      ),

                      // Input field untuk password
                      inputForm(
                        (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "Password Should Not Empty !";
                          }
                          return null;
                        },
                        password: true,
                        controller: passwordController,
                        hintTxt: "Password",
                        helperTxt: "",
                        iconData: Icons.lock,
                        obscureText: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.deepPurpleAccent[400],
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),

                      // const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ForgotPasswordView(),
                                ),
                              );
                            },
                            child: const Text('Lupa password?'),
                            style: TextButton.styleFrom(
                                primary: Colors.deepPurpleAccent[400]),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginView(),
                                ),
                              );
                            },
                            child: const Text(
                                '                                                               '),
                            style: TextButton.styleFrom(
                                primary: Colors.transparent),
                          )
                        ],
                      ),

                      SizedBox(height: 3.h),

                      // Tombol Login dan Daftar

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent[400],
                          minimumSize: Size(350, 55),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            UserClient.login(usernameController.text,
                                    passwordController.text)
                                .then((value) async {
                              if (value != null) {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: const Text('Login Berhasil'),
                                          content: const Text(
                                              'Anda telah berhasil login.'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ));
                                await Future.delayed(
                                    const Duration(seconds: 3));
                                int? userId = value.id;
                                if (userId != null) {
                                  addPrefsId(userId);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const Homepage(),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Login Gagal'),
                                      content: const Text(
                                          'Terjadi kesalahan saat login. Silakan coba lagi.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: const Text(
                                              'Username atau Password Salah!'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                if (mounted) {
                                                  Navigator.pop(context, 'OK');
                                                }
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ));
                              }
                            }).catchError((error) {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: const Text(
                                            'Username atau Password Salah!'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              if (mounted) {
                                                Navigator.pop(context, 'OK');
                                              }
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ));
                            });
                          }
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Map<String, dynamic> formData = {};
                          formData['username'] = usernameController.text;
                          formData['password'] = passwordController.text;
                          pushRegister(context);
                        },
                        child: const Text('Sign Up'),
                        style: TextButton.styleFrom(
                            primary: Colors.deepPurpleAccent[400]),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 1.0.h,
                left: 8.0.w,
                child: InkWell(
                  onTap: () {
                    _toggleTheme(context);
                  },
                  child: Container(
                    width: 10.0.w,
                    height: 10.0.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurpleAccent,
                    ),
                    child: const Center(
                      child: Icon(
                        FontAwesomeIcons.moon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterView(),
      ),
    );
  }

  void _toggleTheme(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleTheme(); // Toggle tema gelap/terang
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
      print(_isPasswordVisible);
    });
  }

  void addPrefsId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', id);
  }
}
