// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';

// import 'package:daycare_app/Screens/Signup/signup_screen.dart';
// import 'package:daycare_app/components/already_have_an_account_acheck.dart';
// import 'package:daycare_app/constants.dart';

// import 'package:daycare_app/Menu/menu_parent_screen.dart';
// import 'package:daycare_app/Menu/menu_caregiver_screen.dart';

// class LoginForm extends StatefulWidget {
//   const LoginForm({super.key});

//   @override
//   _LoginFormState createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<Map<String, dynamic>?> _authenticateUser(String email, String password) async {
//     String jsonString = await rootBundle.loadString('/user.json');
//     List<dynamic> users = jsonDecode(jsonString);

//     for (var user in users) {
//       if (user['email'] == email && user['password'] == password) {
//         return user;
//       }
//     }
//     return null;
//   }

//   void _navigateToMainMenu(BuildContext context, String role) {
//     if (role == 'Parent') {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const ParentScreen()),
//       );
//     } else if (role == 'Caregiver') {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const CaregiverScreen()),
//       );
//     }
//   }

//   void _login(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       String email = _emailController.text;
//       String password = _passwordController.text;

//       Map<String, dynamic>? user = await _authenticateUser(email, password);

//       if (user != null) {
//         _navigateToMainMenu(context, user['role']);
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text("Login Failed"),
//               content: const Text("Invalid email or password"),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text("OK"),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//   }

//   void _navigateToSignUp(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const SignUpScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextFormField(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             decoration: const InputDecoration(
//               hintText: "Your email",
//               prefixIcon: Icon(Icons.person),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your email';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: defaultPadding),
//           TextFormField(
//             controller: _passwordController,
//             textInputAction: TextInputAction.done,
//             obscureText: true,
//             cursorColor: kPrimaryColor,
//             decoration: const InputDecoration(
//               hintText: "Your password",
//               prefixIcon: Icon(Icons.lock),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your password';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: defaultPadding),
//           ElevatedButton(
//             onPressed: () => _login(context),
//             child: Text("Login".toUpperCase()),
//           ),
//           const SizedBox(height: defaultPadding),
//           AlreadyHaveAnAccountCheck(press: () => _navigateToSignUp(context)),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:daycare_app/Screens/Signup/signup_screen.dart';
import 'package:daycare_app/components/already_have_an_account_acheck.dart';
import 'package:daycare_app/constants.dart';

import 'package:daycare_app/Menu/menu_parent_screen.dart';
import 'package:daycare_app/Menu/menu_caregiver_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true; // Initially password is obscure

  // Regular expression for email validation
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
  );

  // Regular expression for password validation
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
  );

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!_emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (!_passwordRegExp.hasMatch(value)) {
      return 'Password must contain at least 8 characters including uppercase, lowercase, and a number';
    }
    return null;
  }

  Future<Map<String, dynamic>?> _authenticateUser(String email, String password) async {
    String jsonString = await rootBundle.loadString('/user.json');
    List<dynamic> users = jsonDecode(jsonString);

    for (var user in users) {
      if (user['email'] == email && user['password'] == password) {
        return user;
      }
    }
    return null;
  }

  void _navigateToMainMenu(BuildContext context, String role) {
    if (role == 'Parent') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ParentScreen()),
      );
    } else if (role == 'Caregiver') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CaregiverScreen()),
      );
    }
  }

  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      Map<String, dynamic>? user = await _authenticateUser(email, password);

      if (user != null) {
        _navigateToMainMenu(context, user['role']);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Login Failed"),
              content: const Text("Invalid email or password"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Icon(Icons.person),
            ),
            validator: _validateEmail,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            obscureText: _isObscure,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              hintText: "Your password",
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
            validator: _validatePassword,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => _login(context),
            child: Text("Login".toUpperCase()),
          ),
          const SizedBox(height: 16.0),
          AlreadyHaveAnAccountCheck(press: () => _navigateToSignUp(context)),
        ],
      ),
    );
  }
}
