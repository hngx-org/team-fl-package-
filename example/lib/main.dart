import 'package:example/ui/authentication_form.dart';
import 'package:example/ui/forgetPassword.dart';
import 'package:example/ui/registration_form.dart';
import 'package:flutter/material.dart';
// find a way to import our authentication service from package folder into this example folder to use
// import 'package:authentica';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return MaterialApp(
        title: 'Authentication Example',
        home: ResetPasswordForm(
            emailController: emailController,
            resetContent: 'A link will be sent to your email',
            successRoutePage: Home() as String));
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
