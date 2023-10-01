import 'package:example/ui/forgetPassword.dart';
import 'package:example/widgets/rounded_bordered_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AuthenticationForm extends StatefulWidget {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final String successRoutePage;
  final String btnText;
  final Color btnColor;

   const AuthenticationForm({super.key, 
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
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(ResetPasswordForm(
                          emailController: emailController,
                          resetContent: '',
                          successRoutePage: '') as String);
                    },
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito',
                          color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                      //  final email = (widget.emailController).text;
                      // final password = (widget.passwordController).text;
                      // final authRepository = (){};
                      //     // Authentication(); // Initialize your repository
                      // final result =
                      //     await authRepository.signIn(email, password);
                      // if (result != null) {
                      //   // Registration failed, display an error message
                      // } else {
                      //   // Registration successful, proceed with your app
                      //   // ignore: use_build_context_synchronously
                      //   Navigator.of(context)
                      //       .pushNamed(widget.successRoutePage);
                      // }
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
