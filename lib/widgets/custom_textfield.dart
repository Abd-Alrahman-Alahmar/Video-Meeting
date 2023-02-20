import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool ? obscureText;
  final Icon iicon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText,
    required this.iicon,
  }) : super(key: key);
  
bool HidePassword () {
  if(obscureText ==null) {
    return false;
  }else return true;
}


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
  
      obscureText: HidePassword(),
      decoration: InputDecoration(
        prefixIcon: iicon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
       // fillColor: const Color(0xffF5F6FA),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}