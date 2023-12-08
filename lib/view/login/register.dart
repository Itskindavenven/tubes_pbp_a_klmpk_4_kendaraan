import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_widget_a_klmpk4/entity/user.dart';
import 'package:pbp_widget_a_klmpk4/view/login/login.dart';
import 'package:pbp_widget_a_klmpk4/client/userClient.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
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

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Sign Up',
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
              key: const Key("Username"),
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
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
            const SizedBox(height: 20),
            TextFormField(
              key: const Key("Email"),
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
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
            const SizedBox(height: 20),
            TextFormField(
              key: const Key("Password"),
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
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
              // Validation logic can be added here
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const Key("PhoneNumber"),
              controller: phoneNumberController,
              decoration: const InputDecoration(
                  labelText: 'Phone Number', border: OutlineInputBorder()),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
            const SizedBox(height: 20),
            TextFormField(
              key: const Key("TglLahir"),
              controller: dobController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                border: const OutlineInputBorder(),
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
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: const Text(
                          'Apakah sudah yakin dengan data yang diisi?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('Belum'),
                        ),
                        TextButton(
                          onPressed: () async {
                            // Perform the registration
                            final newUser = User(
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              noTelp: phoneNumberController.text,
                              tglLahir: dobController.text,
                              image: 'default',
                            );
                            print(newUser);
                            await UserClient.register(newUser);

                            // ignore: use_build_context_synchronously
                            Navigator.of(context)
                                .pop(); // Close the confirmation dialog
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(
                                  data: {'registrationSuccess': true},
                                ),
                              ),
                            );
                          },
                          child: const Text('Sudah'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '),
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Color.fromRGBO(
                          127, 90, 240, 1), // Warna ungu yang diinginkan
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    )))));
  }
}