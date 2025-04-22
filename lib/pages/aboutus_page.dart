import 'dart:async';
import 'package:flutter/material.dart';
import 'package:best_bakes/widgets/navbar.dart'; // ✅ Import Navbar

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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

  // Callback function for handling nav item selection
  void _onNavItemSelected(String selectedItem) {
    print("Selected Nav Item: $selectedItem");
    // You can implement your actual navigation logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ Global Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/photos/backgrnd1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ✅ Main Content with Scrolling and Auto-Hiding Navbar
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                expandedHeight: 80,
                floating: true,
                pinned: false, // ✅ Navbar hides when scrolling down
                flexibleSpace: Navbar(onNavItemSelected: _onNavItemSelected), // ✅ Pass the callback here
              ),
            ],
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 60),
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

                  // ✅ Master Baker Section
                  Row(
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
                          width: 300,
                          height: 450,
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

                  // ✅ Animated Sections
                  LayoutBuilder(
                    builder: (context, constraints) {
                      bool isLargeScreen = constraints.maxWidth > 800;
                      return Column(
                        children: [
                          _animatedImageSection(
                            title: "Our Story",
                            description: "From a humble beginning in 1984...",
                            imagePaths: _storyImages,
                            isLeftAligned: isLargeScreen,
                          ),
                          const SizedBox(height: 40),

                          _animatedImageSection(
                            title: "Our Passion",
                            description:
                                "At Best Bakers, baking is more than a profession...",
                            imagePaths: _passionImages,
                            isLeftAligned: !isLargeScreen,
                          ),
                          const SizedBox(height: 40),

                          _animatedImageSection(
                            title: "Our Commitment",
                            description: "We uphold the highest standards...",
                            imagePaths: _commitmentImages,
                            isLeftAligned: isLargeScreen,
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 60),

                  // ✅ New "See How We Make It" Section
                  _messageFromFoundersSection(),

                  const SizedBox(height: 60),

                  // ✅ Back Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ "See How We Make It" Section
  Widget _messageFromFoundersSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2A38), // ✅ Dark background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ✅ Left Side: Text + Button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Section Title
                const Text(
                  "Message from Founders",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),

                // ✅ Description
                const Text(
                  "In our 'See How We Make It' video, we give you a glimpse into our bakery’s process. Watch as we transform fresh ingredients into delectable treats, showcasing the care and skill that make our pastries and bread exceptional.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ Play Button
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "See How We Make It",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ✅ Right Side: Image with Classic Shape
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(100),
            ),
            child: Image.asset(
              "asset/photos/Screenshot 2025-03-11 113724.png", // ✅ Replace with actual founders' image
              width: 350,
              height: 450,
              fit: BoxFit.cover,
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
            borderRadius: BorderRadius.circular(200),
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
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: isLeftAligned
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: TextStyle(
                fontSize: 18,
                color: textColor,
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
