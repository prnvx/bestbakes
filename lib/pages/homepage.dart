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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialSection != null) {
        _onNavItemSelected(widget.initialSection!);
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_showNavbar) {
        setState(() => _showNavbar = false);
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_showNavbar) {
        setState(() => _showNavbar = true);
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
    if (targetKey != null && targetKey.currentContext != null) {
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
      drawer: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return Drawer(
              backgroundColor: Colors.black87,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.amber),
                    child: Image.asset('asset/photos/logo2-removebg-preview.png'),
                  ),
                  ...["Home", "About", "Menu", "Contact"].map((item) {
                    return ListTile(
                      title: Text(
                        item,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Mallong',
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _onNavItemSelected(item);
                      },
                    );
                  }),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: Stack(
        children: [
          // ✅ Background image
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/photos/backgrnd1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // ✅ Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  KeyedSubtree(key: _heroKey, child: const HeroSection()),
                  KeyedSubtree(key: _aboutKey, child: const AboutSection()),
                  KeyedSubtree(key: _menuKey, child: const ProductPreview()),
                  KeyedSubtree(key: _contactKey, child: const Footer()),
                ],
              ),
            ),
          ),

          // ✅ Responsive Navbar with scroll visibility
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
