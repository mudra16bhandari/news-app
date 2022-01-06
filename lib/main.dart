import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/homescreen.dart';
import 'package:news/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: status == false ? const SignUp() : const HomeScreen()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUp(),
    );
  }
}
