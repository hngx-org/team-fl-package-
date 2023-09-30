import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedBorderedTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  bool isPass;
  final Widget? icon;

  RoundedBorderedTextField({
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.icon,
    required this.controller,
    this.isPass = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              suffixIcon: isPass == true ? icon : null,
            ),
          ),
        ),
      ],
    );
  }
}
