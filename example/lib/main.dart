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
              .signUp(
            'markessien@hng.com.ng',
            'Mark Essien',
          )
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

class Login extends StatelessWidget {
  final Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          auth
              .signIn('markessien@hng.com.ng', 'Hng@planner1')
              .then((responseData) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Successfully signed in: $responseData'),
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
        child: Text('Sign In'),
      ),
    );
  }
}

class Logout extends StatelessWidget {
  final Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          auth.logout('markessien@hng.com.ng').then((responseData) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Successfully logged out: $responseData'),
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
        child: Text('Log Out'),
      ),
    );
  }
}

class ResetPassword extends StatelessWidget {
  final Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          auth.resetPassword('markessien@hng.com.ng').then((responseData) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password reset: $responseData'),
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
        child: Text('Reset Password'),
      ),
    );
  }
}
