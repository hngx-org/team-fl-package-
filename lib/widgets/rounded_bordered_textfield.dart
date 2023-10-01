import 'package:flutter/material.dart';

class RoundedBorderedTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  bool isPass;
  final Widget? icon;

  RoundedBorderedTextField({super.key, 
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.icon,
    this.controller,
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
          child: TextFormField(
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller: controller,
            validator: validator ??
          (val) {
            if ((val?.length ?? 0) == 0) {
              return "Field is required";
            } else {
              return null;
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
