
## Authentication_HNG

A Flutter package for adding authentication to your application. specific to a server


## Usage

[example/lib/main.dart](example/lib/main.dart)
## Example
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
