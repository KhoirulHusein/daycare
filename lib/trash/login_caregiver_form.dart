// // ignore_for_file: library_private_types_in_public_api

// import 'package:daycare_app/Menu/menu_screen.dart';
// import 'package:daycare_app/Screens/Signup/signup_screen.dart';
// import 'package:daycare_app/components/already_have_an_account_acheck.dart';
// import 'package:daycare_app/constants.dart';
// import 'package:flutter/material.dart';

// class LoginCaregiver extends StatefulWidget {
//   const LoginCaregiver({
//     super.key,
//   });

//   @override
//   _LoginFormState createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginCaregiver> {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             onSaved: (email) {},
//             decoration: const InputDecoration(
//               hintText: "Your email",
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(defaultPadding),
//                 child: Icon(Icons.person),
//               ),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your email';
//               }
//               return null;
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//             child: TextFormField(
//               textInputAction: TextInputAction.done,
//               obscureText: true,
//               cursorColor: kPrimaryColor,
//               decoration: const InputDecoration(
//                 hintText: "Your password",
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.lock),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your password';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return const MainMenuScreen();
//                     },
//                   ),
//                 );
//               }
//             },
//             child: Text(
//               "Caregiver Login".toUpperCase(),
//             ),
//           ),
//           const SizedBox(height: defaultPadding),
//           AlreadyHaveAnAccountCheck(
//             press: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return const SignUpScreen();
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:daycare_app/Menu/menu_caregiver_screen.dart';
import 'package:daycare_app/trash/style/login_screen_top_image.dart';
import 'package:daycare_app/Screens/Signup/signup_screen.dart';
import 'package:daycare_app/components/already_have_an_account_acheck.dart';
import 'package:daycare_app/constants.dart';
import 'package:flutter/material.dart';

class LoginCaregiver extends StatefulWidget {
  const LoginCaregiver({super.key});

  @override
  _LoginCaregiverState createState() => _LoginCaregiverState();
}

class _LoginCaregiverState extends State<LoginCaregiver> {
  final _formKey = GlobalKey<FormState>();

  void _navigateToMainMenu(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CaregiverScreen()),
      );
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Login as Caregiver"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const LoginScreenTopImage(),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Your email",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.person),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "Your password",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.lock),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _navigateToMainMenu(context),
                    child: Text("Caregiver Login".toUpperCase()),
                  ),
                  const SizedBox(height: defaultPadding),
                  AlreadyHaveAnAccountCheck(press: () => _navigateToSignUp(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
