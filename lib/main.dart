import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini/app/chatpage.dart';
import 'package:mini/auth/Login.dart';
import 'package:mini/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ChatPage(),
      ),
    ),
  );
}
