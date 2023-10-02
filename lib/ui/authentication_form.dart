// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:hng_authentication/widgets/rounded_bordered_textfield.dart';

class AuthenticationForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String successRoutePage;
  final String btnText;
  final Color btnColor;

  const AuthenticationForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.successRoutePage,
    this.btnText = 'Submit', // Provide a default button text
    this.btnColor = Colors.blue, // Allow the button color to be null (optional)
  });

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  var _obscurePassword = true;
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
                  "Create Account",
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
                const SizedBox(
                  height: 20,
                ),
                RoundedBorderedTextField(
                  hintText: "Email Address",
                  keyboardType: TextInputType.emailAddress,
                  controller: widget.emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundedBorderedTextField(
                  hintText: "Enter Password",
                  obscureText: _obscurePassword,
                  controller: widget.passwordController,
                  isPass: true,
                  icon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color.fromRGBO(115, 106, 185, 1),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
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
                    onPressed: () async {
                      final email = (widget.emailController).text;
                      final password = (widget.passwordController).text;
                      final authRepository =
                          Authentication(); // Initialize your repository
                      final result =
                          await authRepository.signIn(email, password);
                      if (result != null) {
                      } else {
                        Navigator.of(context)
                            .pushNamed(widget.successRoutePage);
                      }
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
