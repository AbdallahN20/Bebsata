import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/main_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delivery_dining, size: 100, color: Colors.blueGrey),
            const SizedBox(height: 20),
            const Text(
              'Bebsata',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,
              fontFamily: 'times new roman'),
            ),
            const SizedBox(height: 10),
            const Text('Fast Delivery at Your Doorstep',
              style: TextStyle(fontWeight: FontWeight.bold,
                  fontFamily: 'times new roman'),
            ),
          ],
        ),
      ),
    );
  }
}