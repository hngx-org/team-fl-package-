import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';

class AuthenticationForm extends StatefulWidget {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final String successRoutePage;
  String btnText;
  Color? btnColor;

  AuthenticationForm({
    required this.emailController,
    required this.passwordController,
    required this.successRoutePage,
    this.btnText = 'Submit', // Provide a default button text
    this.btnColor, // Allow the button color to be null (optional)
  });

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: widget.passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return widget.btnColor; // Color when the button is pressed
                }
                return widget.btnColor; // Default color
              },
            ),
          ),
          onPressed: () async {
            final email = (widget.emailController).text;
            final password = (widget.passwordController).text;
            final authRepository =
                Authentication(); // Initialize your repository
            final result = await authRepository.signIn(email, password);
            if (result != null) {
              // Registration failed, display an error message
            } else {
              // Registration successful, proceed with your app
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamed(widget.successRoutePage);
            }
          },
          child: Text(widget.btnText),
        ),
      ],
    );
  }
}
