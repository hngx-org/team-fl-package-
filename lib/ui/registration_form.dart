import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final String successRoutePage;
  String btnText;
  Color? btnColor;

  RegistrationForm({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.successRoutePage,
    this.btnText = 'Submit', // Provide a default button text
    this.btnColor, // Allow the button color to be null (optional)
  });

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextField(
          controller: widget.emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: widget.passwordController,
          decoration: InputDecoration(labelText: 'Password'),
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
            final name = (widget.nameController).text;
            final email = (widget.emailController).text;
            final password = (widget.passwordController).text;
            final authRepository =
                Authentication(); // Initialize your repository
            final result = await authRepository.signUp(email, name, password);
            if (result != null) {
              // Registration failed, display an error message
            } else {
              // Registration successful, proceed with your app
              Navigator.of(context).pushNamed(widget.successRoutePage);
            }
          },
          child: Text(widget.btnText),
        ),
      ],
    );
  }
}
