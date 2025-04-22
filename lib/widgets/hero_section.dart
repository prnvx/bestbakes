import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart'; // Animation effects
import 'package:animated_text_kit/animated_text_kit.dart'; // Animated text

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image (Full-Screen)
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height, // Full viewport height
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/photos/mae-mu-m9pzwmxm2rk-unsplash.jpg'), // ✅ Ensure the correct path
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Soft Overlay for Better Readability
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.3), // ✅ Slightly stronger overlay for contrast
        ),

        // Animated Main Title (Centered)
        Positioned(
          top: MediaQuery.of(context).size.height * 0.25, // Adjusted for better positioning
          left: 0,
          right: 0,
          child: FadeInDown(
            duration: const Duration(milliseconds: 1000), // ✅ Smooth fade-in effect
            child: Column(
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 600 ? 50 : 80, // Adjust font size based on screen width
                    color: Colors.white,
                    letterSpacing: 3.0,
                    fontFamily: 'Mallong', // ✅ Updated to Mallong font
                    fontWeight: FontWeight.w700,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true, // ✅ Infinite loop
                    animatedTexts: [
                      FadeAnimatedText("BEST BAKERS"),
                      FadeAnimatedText("FRESHLY BAKED EVERYDAY"),
                      FadeAnimatedText("ARTISAN BREAD & PASTRIES"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Subtitle & Description (Bottom Left)
        Positioned(
          bottom: 100, // ✅ Adjusted for better design
          left: MediaQuery.of(context).size.width < 600 ? 20 : 50, // Moves content to the left on mobile
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtitle with Infinite Text Animation
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 600 ? 18 : 24, // Adjust font size for mobile
                  color: Colors.white,
                  letterSpacing: 1.2,
                  fontFamily: 'Mallong', // ✅ Updated to Mallong font
                  fontWeight: FontWeight.w400,
                ),
                child: AnimatedTextKit(
                  repeatForever: true, // ✅ Infinite loop
                  animatedTexts: [
                    FadeAnimatedText("Handmade with Love & Passion"),
                    FadeAnimatedText("Crafted with the Best Ingredients"),
                    FadeAnimatedText("A Taste You Will Love!"),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Description with Infinite Text Animation
              SizedBox(
                width: MediaQuery.of(context).size.width < 600 ? 300 : 400, // Adjust width for mobile
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    letterSpacing: 1.1,
                    height: 1.5,
                    fontFamily: 'Mallong', // ✅ Updated to Mallong font
                    fontWeight: FontWeight.w400,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true, // ✅ Infinite loop
                    animatedTexts: [
                      FadeAnimatedText("At Best Bakers, we bring you the finest selection of artisan bread, pastries, and cakes made fresh daily."),
                      FadeAnimatedText("Using traditional techniques and the best ingredients, we craft baked goods rich in flavor."),
                      FadeAnimatedText("Experience the art of baking like never before."),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
