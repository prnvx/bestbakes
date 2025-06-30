import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // make sure this file exists
import 'package:best_bakes/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bistro Bakery',
      theme: ThemeData(
        fontFamily: 'Mallong',
        primarySwatch: Colors.brown,
      ),
      home: const MainLayout(),
      routes: {
        '/home': (context) => const HomePage(),
      },
    );
  }
}

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/photos/backgrnd1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          height: isMobile
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.height * 1.2,
        ),
        const HomePage(),
      ],
    );
  }
}
