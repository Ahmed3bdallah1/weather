import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:weather_app/ui/home_screen.dart';
import 'package:weather_app/ui/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'weather app',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        HomeScreen.route:(BuildContext context)=> const HomeScreen(),
      },
    );
  }
}