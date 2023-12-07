import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Padding inputForm(
  String? Function(String?)? validasi, {
  required TextEditingController controller,
  required String hintTxt,
  required String helperTxt,
  required IconData iconData,
  bool password = false,
  Widget? suffixIcon,
  bool obscureText = false,
  bool readOnly = false, // Tambahkan parameter bool 'readOnly'
  VoidCallback? onTap, // Tambahkan parameter VoidCallback 'onTap'
}) {
  return Padding(
    padding: EdgeInsets.only(left: 2.w, top: 2.h),
    child: SizedBox(
      width: 90.w,
      child: TextFormField(
        validator: validasi, // Gunakan validasi langsung
        autofocus: true,
        controller: controller,
        obscureText: password && obscureText,
        readOnly: readOnly, // Set readOnly
        onTap: onTap, // Set onTap
        decoration: InputDecoration(
          hintText: hintTxt,
          border: const OutlineInputBorder(),
          helperText: helperTxt,
          prefixIcon: Icon(iconData),
          suffixIcon: suffixIcon,
        ),
      ),
    ),
  );
}
