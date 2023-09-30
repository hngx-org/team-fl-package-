import 'package:example/ui/authentication_form.dart';
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
    return MaterialApp(
      title: 'Authentication Example',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              ElevatedButton(
              onPressed: () async {
                // await 
                //  AuthRepository.signUp('user@example.com', 'password123');
                // Handle sign-up success or failure.
              },
              child: Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () async {
                // await authManager.login('user@example.com', 'password123');
                // Handle login success or failure.
              },
              child: Text('Log In'),
            ),
          ],
        ),
      ),
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
