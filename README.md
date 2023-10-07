
## HNG_Authentication

A Flutter package for adding authentication to your application. This package offer the client the ability to call the signup, signin, logout functions and also check currently logged in user. This is package can be used in any HNG task involving authentication.

## Overview

This is an authentication package for Flutter applications. It provides functionalities for user registration, login, and user management through an API.

## Features

- User registration
- User login
- User logout
- Get user profile information

## Installation

To use this package, add it to your `pubspec.yaml`:

```yaml
dependencies:
  hng_authentication: ^1.0.0
```

Then run flutter pub get to install the package.


## Usage

Import the package


```
import 'package:hng_authentication/hng_authentication.dart';

```


## Initialize the Authentication

```
final authentication = Authentication();

```

## User Registration

```try {
  final user = await authentication.signUp(email, name, password);
  // Handle success, e.g., store user information
} catch (error) {
  // Handle errors
}
```

## User Login 

```try {
  final user = await authentication.signIn(email, password);
  // Handle success, e.g., store user information
} catch (error) {
  // Handle errors
}
```
## User Logout 

```try {
  await authentication.logout(email);
  // Handle success, e.g., navigate to the login screen
} catch (error) {
  // Handle errors
}

```
## Get User Profile 

```try {
  final user = await authentication.getUser();
  // Handle success, e.g., display user information
} catch (error) {
  // Handle errors
}


```

## API Configuration

The package uses the following API endpoint:

```static const String baseUrl = 'https://spitfire-interractions.onrender.com/api/auth';
```

## Example
```dart
import 'package:flutter/material.dart';
import 'package:hng_authentication/authentication.dart';


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
      routes: {
        '/': (context) => RegistrationForm(
              emailController: emailController,
              successRoutePage: '/home', 
              nameController: nameController, 
              passwordController: passwordController, // Use the route name here
            ),
        '/home': (context) => const Home(), // Define a route for Home
      },
      initialRoute: '/',
    );
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

class RegistrationForm extends StatefulWidget {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final String successRoutePage;
  String btnText;
  Color btnColor;

  RegistrationForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.successRoutePage,
    this.btnText = 'Submit', // Provide a default button text
    this.btnColor =
        Colors.green, // Allow the button color to be null (optional)
  });

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool _obscurePassword = true;
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
                  hintText: "Username",
                  controller: widget.nameController,
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
                RoundedBorderedTextField(
                  hintText: "Confirm Password",
                  obscureText: _obscurePassword,
                  validator: (val) {
                    if (val?.isEmpty ?? true) {
                      return 'Please enter your password';
                    } else if ((val?.length ?? 0) < 6) {
                      return 'Password is not up to 6 characters';
                    } else if (((val?.length ?? 0) >= 6) &&
                        ((val ?? "") != widget.passwordController.text)) {
                      return "Password texts don't match";
                    } else {
                      return null;
                    }
                  },
                  // controller: widget.passwordController,
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
                      final name = widget.nameController.text;
                      final authRepository = Authentication();
                      final data =
                          await authRepository.signUp(email, name, password);
                      if (data != null) {
                        // Registration failed, display an error message

                        showSnackbar(
                            context, Colors.black, 'SignUp successful');
                        print('sign up Email >>> ${data.email}');
                        print('sign up id >>> ${data.id}');
                        print('sign up created at >>> ${data.createdAt}');
                        Navigator.of(context)
                            .pushNamed(widget.successRoutePage);
                      } else {
                        print('errror:   eeeeeee');
                        showSnackbar(context, Colors.red, 'SignUp ERROR');
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


```

## Exception Handling
The package provides custom exceptions and handles various HTTP error codes.

## Dependencies
http: ^0.13.3
shared_preferences: ^2.0.7

## License
This package is open-source and available under the MIT License. See the LICENSE file for details.


## Contributions

Contributions are welcome! Please open an issue or create a pull request to contribute to this package.
