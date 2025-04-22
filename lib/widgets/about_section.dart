import 'package:best_bakes/pages/aboutus_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  int _currentImageIndex = 0;

  final List<String> _storyImages = [
    "asset/photos/food1.jpg",
    "asset/photos/food2.jpg",
    "asset/photos/food3.jpg",
  ];

  final List<String> _passionImages = [
    "asset/photos/food2.jpg",
    "asset/photos/food3.jpg",
    "asset/photos/food1.jpg",
  ];

  final List<String> _commitmentImages = [
    "asset/photos/food3.jpg",
    "asset/photos/food1.jpg",
    "asset/photos/food2.jpg",
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentImageIndex = (_currentImageIndex + 1) % _storyImages.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: width < 600 ? 20 : 60, // More padding for larger screens
      ),
      color: Colors.transparent, // Allows global background visibility
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "About Us",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Mallong',
              color: Colors.orange.shade400,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 40),

          // For mobile, stack vertically; for large screens, display side by side
          width < 600
              ? Column(
                  children: [
                    _textBox(
                      title: "Meet the Master Baker",
                      description:
                          "Our head baker is the creative mind behind every loaf. With years of experience, a deep passion for baking, and an eye for perfection, every product is a reflection of their artistry and craftsmanship.",
                      backgroundColor: const Color(0xFF1E2A38),
                      textColor: Colors.white,
                      isLeftAligned: true,
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'asset/photos/chef.jpg',
                        width: width < 600 ? 300 : 400, // Adjust image size
                        height: width < 600 ? 450 : 600,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _textBox(
                      title: "Our Passion for Perfection",
                      description:
                          "At Best Bakers, our dedication to quality is unmatched. We ensure that every bite of our products is filled with rich flavors, made using premium ingredients, and crafted with love and care.",
                      backgroundColor: const Color(0xFFF4D06F),
                      textColor: Colors.black,
                      isLeftAligned: false,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _textBox(
                      title: "Meet the Master Baker",
                      description:
                          "Our head baker is the creative mind behind every loaf. With years of experience, a deep passion for baking, and an eye for perfection, every product is a reflection of their artistry and craftsmanship.",
                      backgroundColor: const Color(0xFF1E2A38),
                      textColor: Colors.white,
                      isLeftAligned: true,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'asset/photos/chef.jpg',
                        width: 400,
                        height: 600,
                        fit: BoxFit.cover,
                      ),
                    ),
                    _textBox(
                      title: "Our Passion for Perfection",
                      description:
                          "At Best Bakers, our dedication to quality is unmatched. We ensure that every bite of our products is filled with rich flavors, made using premium ingredients, and crafted with love and care.",
                      backgroundColor: const Color(0xFFF4D06F),
                      textColor: Colors.black,
                      isLeftAligned: false,
                    ),
                  ],
                ),

          const SizedBox(height: 70),

          _animatedImageSection(
            title: "Our Story",
            description:
                "From a humble beginning in 1984, Best Bakers has grown into a beloved name in the baking industry...",
            imagePaths: _storyImages,
            isLeftAligned: true,
          ),

          const SizedBox(height: 40),

          _animatedImageSection(
            title: "Our Passion",
            description:
                "At Best Bakers, baking is more than just a profession—it’s our passion...",
            imagePaths: _passionImages,
            isLeftAligned: false,
          ),

          const SizedBox(height: 40),

          _animatedImageSection(
            title: "Our Commitment",
            description:
                "We are committed to upholding the highest standards in every aspect of our bakery...",
            imagePaths: _commitmentImages,
            isLeftAligned: true,
          ),

          const SizedBox(height: 60),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: const Text(
              "Know More",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _animatedImageSection({
    required String title,
    required String description,
    required List<String> imagePaths,
    required bool isLeftAligned,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isLeftAligned) _textContainer(title, description),
        AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: ClipRRect(
            key: ValueKey<String>(imagePaths[_currentImageIndex]),
            borderRadius: BorderRadius.only(
              topLeft: isLeftAligned ? Radius.circular(200) : Radius.zero,
              bottomLeft: isLeftAligned ? Radius.circular(200) : Radius.zero,
              topRight: !isLeftAligned ? Radius.circular(200) : Radius.zero,
              bottomRight: !isLeftAligned ? Radius.circular(200) : Radius.zero,
            ),
            child: Image.asset(
              imagePaths[_currentImageIndex],
              width: 500,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (isLeftAligned) _textContainer(title, description),
      ],
    );
  }

  Widget _textBox({
    required String title,
    required String description,
    required Color backgroundColor,
    required Color textColor,
    required bool isLeftAligned,
  }) {
    return Expanded(
      child: Container(
        height: 450,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: isLeftAligned ? const Radius.circular(10) : Radius.zero,
            bottomLeft: isLeftAligned ? const Radius.circular(10) : Radius.zero,
            topRight: !isLeftAligned ? const Radius.circular(10) : Radius.zero,
            bottomRight: !isLeftAligned ? const Radius.circular(10) : Radius.zero,
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isLeftAligned ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Mallong',
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: isLeftAligned ? TextAlign.left : TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Mallong',
                color: textColor.withOpacity(0.9),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textContainer(String title, String description) {
    return Container(
      width: 650,
      height: 400,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2A38),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFD1D7E0),
            ),
          ),
        ],
      ),
    );
  }
}
