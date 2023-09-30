import 'package:authentication/src/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../example/lib/main.dart';

void main() {
  testWidgets('Signup Widget Test', (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(MaterialApp(home: Signup()));

    // Verify that the widget displays the "Sign Up" text
    expect(find.text('Sign Up'), findsOneWidget);

    // Simulate a tap on the "Sign Up" button
    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    // Replace this with your authentication success assertions
    // expect(find.text('Successfully signed up: your email and password'),
    //     findsOneWidget);

    // // Replace this with your authentication failure assertions
    // expect(find.text('Error: Your_Error_Message'), findsOneWidget);

    // For example, you can check if a SnackBar is displayed after a successful signup
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Login Widget Test', (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(MaterialApp(home: Login()));

    // Verify that the widget displays the "Sign In" text
    expect(find.text('Sign In'), findsOneWidget);

    // Simulate a tap on the "Sign In" button
    await tester.tap(find.text('Sign In'));
    await tester.pump();

    // Replace this with your authentication success/failure assertions
    // For example, you can check if a SnackBar is displayed after a successful login
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Logout Widget Test', (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(MaterialApp(home: Logout()));

    // Verify that the widget displays the "Log Out" text
    expect(find.text('Log Out'), findsOneWidget);

    // Simulate a tap on the "Log Out" button
    await tester.tap(find.text('Log Out'));
    await tester.pump();

    // Replace this with your authentication success/failure assertions
    // For example, you can check if a SnackBar is displayed after a successful logout
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('ResetPassword Widget Test', (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(MaterialApp(home: ResetPassword()));

    // Verify that the widget displays the "Reset Password" text
    expect(find.text('Reset Password'), findsOneWidget);

    // Simulate a tap on the "Reset Password" button
    await tester.tap(find.text('Reset Password'));
    await tester.pump();

    // Replace this with your authentication success/failure assertions
    // For example, you can check if a SnackBar is displayed after a password reset request
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
