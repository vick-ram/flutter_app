import 'package:flutter/material.dart';
import 'package:flutter_app/ui/ProductDetails.dart';

import '../ui/HomeScreen.dart';
import '../ui/SignInScreen.dart';
import '../ui/SignUpScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Signinscreen(),
        '/home': (context) => const Homescreen(),
        '/signUp': (context) => const Signupscreen(),
        '/details': (context) => const ProductDetails()
      },
    );
  }
}
