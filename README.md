
## HNG_Authentication

A Flutter package for adding authentication to your application. This package offer the client the ability to call the signup, signin, logout functions and also check currently logged in user. This is package can be used in any HNG task involving authentication.


## Usage

To use this plugin, add hng_authentiction as a dependency in your pubspec.yaml file.
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
## API Documentation
The HNG_Authentication package provides the following API for authentication:

signUp(email, name, password): Sign up a new user.
signIn(email, password): Sign in an existing user.
logout(email): Log out the user associated with the provided email.
getUser(): Retrieve information about the currently authenticated user.
Each of these functions can be called to perform the corresponding authentication task.

## Troubleshooting
If you encounter any issues during the installation or use of this package, please check your dependencies and ensure you have imported the package correctly.

## License
This package is licensed under the MIT License. See the LICENSE file for details.

## Contributing
We welcome contributions! If you'd like to contribute to this package, please follow our contribution guidelines.

## Version History
0.0.1 - Initial release (30th Sept 2023)
0.0.2 - Bug fixes and improvements (1st Sept 2023)
0.0.3 - Bug fixes and improvements (2nd Sept 2023)
0.1.0 - Bug fixes and improvements (3rd Sept 2023)
0.1.1 - Bug fixes and improvements (3rd Sept 2023)
0.1.2 - Bug fixes and improvements also add user model (3rd Sept 2023TE)
0.1.3 - Bug fixes and improvements (4th Sept 2023)
0.1.4 - Bug fixes and improvements added cookie property so you can now retrieve cookies (4th Sept 2023)
0.1.5 - Bug fixes and improvements (5th Sept 2023)
0.1.6 - Bug fixes and improvements added cookie property so you can now retrieve cookies (5th Sept 2023)

## Testing
The package includes test cases to ensure its functionality. You can run tests by executing the following command:


## Additional Documentation
For more detailed documentation and examples, please visit the official documentation here.

## Support
If you have any questions or need assistance, please contact our support team at support@example.com.

Thank you for using HNG_Authentication!



