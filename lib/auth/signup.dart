// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini/auth/login.dart';
import 'package:mini/widgets/field.dart';
import 'package:transition/transition.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController retyprpasscontroller = TextEditingController();
    TextEditingController username = TextEditingController();

    void nav() {
      Navigator.of(context).pushReplacement(
        Transition(
            child: const Login(),
            transitionEffect: TransitionEffect.RIGHT_TO_LEFT),
      );
    }

    Future<void> signUp(String email, String password) async {
      try {
        if (password != retyprpasscontroller.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('the passwords dont match'),
              backgroundColor: Colors.red,
            ),
          );

          return;
        }
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user = FirebaseAuth.instance.currentUser;
        user?.updateDisplayName(username.text);

        nav();
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/dalmatian-spots.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Center(
                child: customTextBox(
                  "email",
                  Icons.email_outlined,
                  false,
                  emailController,
                ),
              ),
              customTextBox(
                  "username", Icons.account_circle_sharp, false, username),
              customTextBox(
                "password",
                Icons.password_outlined,
                true,
                passwordController,
              ),
              customTextBox("retype password", Icons.password_rounded, true,
                  retyprpasscontroller),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "aleredy have an account?",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  TextButton(
                    onPressed: () {
                      nav();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  signUp(emailController.text, passwordController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 214, 146, 121),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
