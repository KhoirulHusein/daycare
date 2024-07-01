import 'package:daycare_app/Menu/default_screen.dart';
import 'package:daycare_app/Menu/menu_caregiver_screen.dart';
import 'package:daycare_app/Menu/menu_parent_screen.dart';
import 'package:flutter/material.dart';
import 'package:daycare_app/Screens/Welcome/welcome_screen.dart';
import 'package:daycare_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userEmail = prefs.getString('userEmail');
  String? userRole = prefs.getString('userRole');

  runApp(MyApp(userEmail: userEmail, userRole: userRole));
}

class MyApp extends StatelessWidget {
  final String? userEmail;
  final String? userRole;
 
  const MyApp({super.key, this.userEmail, this.userRole});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SPARKLE DAYCARE',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kPrimaryLightColor,
          iconColor: kPrimaryColor,
          prefixIconColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: userEmail != null && userRole != null
          ? _buildMainMenu(userRole!) // Function to determine which main menu to show
          : const WelcomeScreen(),
    );
  }

  Widget _buildMainMenu(String role) {
    switch (role) {
      case 'Parent':
        return const ParentScreen();
      case 'Caregiver':
        return const CaregiverScreen();
      default:
        return const DefaultScreen();
    }
  }
}
