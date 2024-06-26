// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRole;
  String? _email;
  String? _password;
  String? _confirmPassword;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
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
              // Email validation using regex
              if (!_isValidEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              obscureText: _obscurePassword,
              cursorColor: kPrimaryColor,
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                // Password validation using regex
                // if (!_isValidPassword(value)) {
                //   return 'Password needs 8 characters with at least one uppercase letter, one lowercase letter, and one number.';
                // }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 6),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: _obscureConfirmPassword,
              cursorColor: kPrimaryColor,
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Confirm password",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _password) {
                  return 'Passwords do not match';
                } if (!_isValidPassword(value)) {
                  return 'Password needs 8 characters with at least one uppercase letter, one lowercase letter, and one number.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          DropdownButtonFormField<String>(
            value: _selectedRole,
            hint: const Text("Select Role"),
            items: ["Parent", "Caregiver"]
                .map((role) => DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a role';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Registration Successful"),
                      content:
                          const Text("You have successfully registered!"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginScreen();
                                },
                              ),
                            );
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Email validation using regex
    return RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
        .hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // Password validation using regex
    return RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$").hasMatch(password);
  }
}
