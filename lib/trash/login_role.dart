// // ignore_for_file: library_private_types_in_public_api

// import 'package:daycare_app/Menu/menu_screen.dart';
// import 'package:flutter/material.dart';

// import '../../../components/already_have_an_account_acheck.dart';
// import '../../../constants.dart';
// import '../../Signup/signup_screen.dart';

// class LoginForm extends StatefulWidget {
//   const LoginForm({
//     super.key,
//   });

//   @override
//   _LoginFormState createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
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
//               "Login".toUpperCase(),
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

// ignore_for_file: library_private_types_in_public_api

import 'package:daycare_app/trash/login_caregiver_form.dart';
import 'package:daycare_app/trash/login_parent_form.dart';
import 'package:daycare_app/constants.dart';
import 'package:flutter/material.dart';


class LoginRole extends StatefulWidget {
  const LoginRole({
    super.key,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginRole> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginParent();
                    },
                  ),
                );
              }
            },
            child: Text(
              "Login as Parent".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginCaregiver();
                    },
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryLightColor,
              elevation: 0,
            ),
            child: Text(
              "Login as Caregiver".toUpperCase(),
                style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
