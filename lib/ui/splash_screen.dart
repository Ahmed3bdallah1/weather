import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/constant.dart';
import 'package:weather_app/ui/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  void reloadApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SplashScreen()),
    );
  }

  void exitApp() {
    Navigator.pop(context);
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    } else {
      setState(() {
        isConnected = true;
      });
    }

    Timer(const Duration(seconds: 3), () {
      if (isConnected) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      } else {
        showDialog(
            context: context,
            builder: (_) {
              return CupertinoAlertDialog(
                  title: const Text("check connection first"),
                  actions: [
                    CupertinoDialogAction(
                        child: const Text("retry"),
                        onPressed: () {
                          reloadApp();
                        }),
                    CupertinoDialogAction(
                        child: const Text("exit"),
                        onPressed: () {
                          exitApp();
                        })
                  ]);
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().primaryColor,
      body: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
