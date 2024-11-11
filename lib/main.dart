import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shutter_ease/firebase_options.dart';
import 'package:shutter_ease/my_app.dart';
import 'package:shutter_ease/theme/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}


  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
    );
  }