import 'dart:ui';
import 'package:flutter/material.dart';

class ProductDetailPopup extends StatelessWidget {
  final String name;
  final String image;

  const ProductDetailPopup({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width to determine if it's mobile or desktop
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 100, // Adjusted horizontal padding for mobile/desktop
        vertical: isMobile ? 40 : 60,    // Adjusted vertical padding for mobile/desktop
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 28 : 40,  // Adjusted padding for mobile/desktop
                  vertical: isMobile ? 32 : 50,    // Adjusted padding for mobile/desktop
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            image,
                            width: isMobile ? 220 : 260, // Adjusted image width for mobile/desktop
                            height: isMobile ? 220 : 260, // Adjusted image height for mobile/desktop
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.6),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Mallong',
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 36),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true); // returning true to show success
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 10,
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          fontFamily: 'Mallong',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -12,
            right: -12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.close, size: 22, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
