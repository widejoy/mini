import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini/auth/Login.dart';
import 'package:mini/firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:mini/models/chat_message.dart';
import 'package:mini/models/user_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox<UserModel>('users');
  await Hive.openBox<ChatMessage>('chat_messages');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Login(),
      ),
    ),
  );
}
