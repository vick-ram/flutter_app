import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/remote/api/services/user_service.dart';
import 'package:flutter_app/di/service_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/Input.dart';
import '../widgets/Button.dart';

class Signinscreen extends StatefulWidget {
  const Signinscreen({super.key});

  @override
  State<Signinscreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<Signinscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await GetIt.I.getAsync<SharedPreferences>();
    final token = prefs.getString('token');
    if (!mounted) return;
    if (token != null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() {
      isLoading = true;
    });

    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all the fields')));
      return;
    }

    try {
      final dio = getIt<Dio>();
      final prefs = await GetIt.I.getAsync<SharedPreferences>();
      final login = getIt<UserService>().login;

      final res = await login(
        dio,
        prefs,
        email,
        password,
      );

      if (!mounted) return;

      if (res.success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res.message)));
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${res.message}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    // clear the input fields
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/rustic_logo.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const Text(
              'Sign In',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Input(
                keybordType: TextInputType.emailAddress,
                controller: emailController,
                hint: 'john@gmail.com'),
            Input(
              controller: passwordController,
              hint: 'Your password',
              isPassword: true,
            ),
            Button(
              label: 'sign in',
              onPressed: _signIn,
              loading: isLoading,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: <Widget>[
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                    child: const Text('Sign up'))
              ],
            )
          ],
        ),
      ))),
    ));
  }
}
