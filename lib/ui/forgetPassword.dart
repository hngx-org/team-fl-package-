// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hng_authentication/widgets/rounded_bordered_textfield.dart';

// ignore: must_be_immutable
class ResetPasswordForm extends StatefulWidget {
  late final TextEditingController emailController;
  final String resetContent;

  final String successRoutePage;
  String btnText;
  Color btnColor;

  ResetPasswordForm({
    super.key,
    required this.emailController,
    required this.successRoutePage,
    required this.resetContent,
    this.btnText = 'Submit', // Provide a default button text
    this.btnColor =
        Colors.green, // Allow the button color to be null (optional)
  });

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.04,
            right: screenWidth * 0.04,
            top: 20,
            bottom: 0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Forgot Password",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      letterSpacing: .5,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.resetContent,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      letterSpacing: .5,
                      fontSize: 16,
                    ),
                  ),
                ),
                RoundedBorderedTextField(
                  hintText: "Email Address",
                  keyboardType: TextInputType.emailAddress,
                  controller: widget.emailController,
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // RoundedBorderedTextField(
                //   hintText: "Enter Password",
                //   obscureText: _obscurePassword,
                //   controller: widget.passwordController,
                //   isPass: true,
                //   icon: IconButton(
                //     icon: Icon(
                //       _obscurePassword
                //           ? Icons.visibility_off
                //           : Icons.visibility,
                //       color: Color.fromRGBO(115, 106, 185, 1),
                //     ),
                //     onPressed: () {
                //       setState(() {
                //         _obscurePassword = !_obscurePassword;
                //       });
                //     },
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        widget.btnColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(widget.successRoutePage);
                    },
                    child: Text(
                      widget.btnText,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          letterSpacing: .16,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
