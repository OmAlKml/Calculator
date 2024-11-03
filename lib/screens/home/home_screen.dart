import 'package:calculator/screens/calculator/calc_screen.dart';
import 'package:calculator/screens/drawer/side_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF6A5ACD),
          foregroundColor: Colors.white,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6A5ACD),
                Color(0xFF00CED1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(children: [
            _screenContent(),
          ]),
        ),
        drawer: const SideDrawer());
  }

  Widget _screenContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black,
              height: 250,
              width: 250,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 200,
                height: 400,
                fit: BoxFit.contain,
                colorBlendMode: BlendMode.darken,
              ),
            ),
            const Text(
              "Welcome to the calculator app",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: "cairo",
              ),
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to CalculatorScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalculatorScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.black,
                padding: const EdgeInsets.all(24.0), // Adjust size here
              ),
              child: const Text(
                "Start",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
