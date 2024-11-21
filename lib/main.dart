import 'package:flutter/material.dart';
import 'package:flutter_app/data/local/db/sync.dart';
import 'package:flutter_app/di/service_locator.dart';
import 'package:flutter_app/ui/cart_screen.dart';
import 'package:flutter_app/ui/product_details.dart';

import 'ui/home_screen.dart';
import 'ui/signin_screen.dart';
import 'ui/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  await getIt.allReady();
  final syn = await getIt.getAsync<Sync>();
  syn.syncUser();
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
        '/details': (context) => const ProductDetails(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
