import 'package:flutter/material.dart';
import 'package:best_bakes/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the device is mobile or desktop
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bistro Bakery',
      theme: ThemeData(
        fontFamily: 'Mallong', // ✅ Now using Mallong font
        primarySwatch: Colors.brown,
      ),
      home: Stack(
        children: [
          // ✅ Global Background Pattern (Applies to All Screens)
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/photos/backgrnd1.jpg'), // ✅ Background Pattern
                fit: BoxFit.cover, // ✅ Full coverage
              ),
            ),
            // Adjust background size for mobile and desktop
            height: isMobile ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * 1.2, // Adjust height based on screen size
          ),

          // ✅ HomePage Stacked Over Background
          const HomePage(),
        ],
      ),
      routes: {
        '/home': (context) => const HomePage(), // Route to HomePage
      },
    );
  }
}

