import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/product_preview.dart';
import '../widgets/footer.dart';

class HomePage extends StatefulWidget {
  final String? initialSection;
  const HomePage({super.key, this.initialSection});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showNavbar = true;

  // Keys for scrolling to sections
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Jump to section after frame render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialSection != null) {
        _onNavItemSelected(widget.initialSection!);
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_showNavbar) {
        setState(() {
          _showNavbar = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_showNavbar) {
        setState(() {
          _showNavbar = true;
        });
      }
    }
  }

  void _onNavItemSelected(String title) {
    final sectionMap = {
      "Home": _heroKey,
      "About": _aboutKey,
      "Menu": _menuKey,
      "Contact": _contactKey,
    };

    final targetKey = sectionMap[title];
    if (targetKey != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                KeyedSubtree(
                  key: _heroKey,
                  child: const HeroSection(),
                ),
                // About Section
                KeyedSubtree(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),
                // Menu Section (Product Preview)
                KeyedSubtree(
                  key: _menuKey,
                  child: const ProductPreview(),
                ),
                // Footer (Contact Section)
                KeyedSubtree(
                  key: _contactKey,
                  child: const Footer(),
                ),
              ],
            ),
          ),

          // Navbar with scroll-based visibility
          LayoutBuilder(
            builder: (context, constraints) {
              bool isLargeScreen = constraints.maxWidth > 800;
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: _showNavbar ? 0 : (isLargeScreen ? -60 : -80),
                left: 0,
                right: 0,
                child: Navbar(onNavItemSelected: _onNavItemSelected),
              );
            },
          ),
        ],
      ),
    );
  }
}
