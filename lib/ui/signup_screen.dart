import 'package:flutter/material.dart';

import '../widgets/input.dart';
import '../widgets/button.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<Signupscreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: <Widget>[
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Input(controller: firstNameController, hint: 'John'),
                Input(controller: lastNameController, hint: 'Doe'),
                Input(
                    keybordType: TextInputType.emailAddress,
                    controller: emailController,
                    hint: 'john@gmail.com'),
                Input(
                  controller: passwordController,
                  hint: '*********',
                  isPassword: true,
                ),
                Input(controller: phoneController, hint: '0712345678'),
                Button(
                  label: 'Sign Up',
                  onPressed: () {},
                  loading: isLoading,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
