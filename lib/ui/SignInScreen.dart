import 'package:flutter/material.dart';
import 'package:flutter_app/api/constants.dart';
import 'package:flutter_app/api/services/userService.dart';

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

  void _checkLoginStatus() async {
    final prefs = await initializePreferences();
    final token = prefs.getString('token');
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

  void _signIn() async {
    final email = emailController.text;
    final password = passwordController.text;

    final prefs = await initializePreferences();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all the fields')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    final res = await login(email, password, prefs);

    setState(() {
      isLoading = false;
    });

    if (res.success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res.message)));
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res.message)));
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
            Input(controller: emailController, hint: 'john@gmail.com'),
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
