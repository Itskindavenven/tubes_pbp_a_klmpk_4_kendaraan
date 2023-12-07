import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/login/change_password.dart';
import 'package:pbp_widget_a_klmpk4/component/form_component.dart';
import 'package:pbp_widget_a_klmpk4/client/UserClient.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordView extends StatefulWidget {
  final Map? data;

  const ForgotPasswordView({Key? key, this.data}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Verifikasi Email Anda',
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
                          return "Email tidak boleh kosong";
                        }
                        return null;
                      },
                      controller: emailController,
                      hintTxt: "Email",
                      helperTxt: "Inputkan email anda",
                      iconData: Icons.mail,
                      suffixIcon: null,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            UserClient.validasi(emailController.text)
                                .then((value) async {
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
                                          ChangePassword(userId: userId),
                                    ),
                                  );
                                }
                              } else {
                                showSnackBar(
                                    context, "Validasi gagal", Colors.red);
                              }
                            }).catchError((error) {
                              showSnackBar(
                                  context, "Validasi gagal", Colors.red);
                            });
                          }
                        },
                        child: const Text('Validasi'))
                  ],
                )),
          )
        ],
      ),
    ));
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
      action: SnackBarAction(
          label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
