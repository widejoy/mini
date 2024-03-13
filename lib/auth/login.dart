// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini/app/homepage.dart';
import 'package:mini/auth/signup.dart';
import 'package:mini/widgets/field.dart';
import 'package:transition/transition.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usercont = TextEditingController();
    TextEditingController passcont = TextEditingController();
    Future<void> login(String email, String password) async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Sucesfull'),
            backgroundColor: Colors.blue,
          ),
        );
        Navigator.of(context).pushReplacement(
          Transition(
              child: const HomePage(),
              transitionEffect: TransitionEffect.LEFT_TO_RIGHT),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    void nav(String text) {
      Navigator.of(context).pushReplacement(Transition(
          child: const SignUp(),
          transitionEffect: TransitionEffect.LEFT_TO_RIGHT));
    }

    Future<void> resetPassword(String email) async {}

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.37),
              Center(
                child: customTextBox(
                  "email",
                  Icons.email_outlined,
                  false,
                  usercont,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              customTextBox(
                "password",
                Icons.password_outlined,
                true,
                passcont,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account yet?",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  TextButton(
                    onPressed: () {
                      nav(usercont.text);
                    },
                    child: const Text(
                      "SignUp",
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
                  login(usercont.text, passcont.text);
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
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  resetPassword(usercont.text);
                },
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(
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
