<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
## Authentication_HNG

A Flutter package for adding authentication to your application.

## Features



## Getting started

- [Installing](installing.md)
- [Changelog](CHANGELOG.md)
- [License](LICENSE)

## Usage

[example/lib/main.dart](example/lib/main.dart)

```dart
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  final Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          auth
              .signUp('test@example.com', 'John Doe', 'password')
              .then((responseData) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Successfully signed up: $responseData'),
                duration: Duration(seconds: 2),
              ),
            );
          }).catchError((e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
                duration: Duration(seconds: 2),
              ),
            );
          });
        },
        child: Text('Sign Up'),
      ),
    );
  }
}

```

<!-- ## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more. -->
