import 'package:best_bakes/pages/aboutus_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:best_bakes/widgets/navbar.dart';
import 'package:best_bakes/pages/categoryproductpage.dart';
import 'package:best_bakes/pages/homepage.dart';


class ProductGalleryPage extends StatefulWidget {
  const ProductGalleryPage({super.key});

  @override
  _ProductGalleryPageState createState() => _ProductGalleryPageState();
}

class _ProductGalleryPageState extends State<ProductGalleryPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showNavbar = true;

  Map<String, bool> _isHovered = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse && _showNavbar) {
        setState(() => _showNavbar = false);
      } else if (direction == ScrollDirection.forward && !_showNavbar) {
        setState(() => _showNavbar = true);
      }
    });
  }

  void _onNavItemSelected(String title) {
    if (title == "Home") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (title == "About") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AboutPage()),
      );
    } else if (title == "Contact") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage(initialSection: 'Contact')),
      );
    }
    // No action needed for "Menu" because we're already on ProductGalleryPage
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'image': 'asset/photos/freshcreamcakes/chocolatecake.jpg',
        'name': 'Fresh Cream Cakes'
      },
      {
        'image': 'asset/photos/juicesandshakes/chocolateshake.jpg',
        'name': 'Juices & Shakes'
      },
      {
        'image': 'asset/photos/gifthampersandsweetbox/birthdaysweetbox.jpg',
        'name': 'Gift Hampers & Sweet Box'
      },
      {
        'image': 'asset/photos/snacks/chickenburger.jpg',
        'name': 'Snacks'
      },
    ];

    return Scaffold(
      drawer: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return Drawer(
              backgroundColor: Colors.black87,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/photos/backgrnd1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                floating: true,
                pinned: true,
                toolbarHeight: 80,
                flexibleSpace: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _showNavbar ? 1.0 : 0.0,
                  child: Navbar(onNavItemSelected: _onNavItemSelected),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Browse By Category',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Mallong',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Welcome to the Product Gallery!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontFamily: 'Mallong',
                        ),
                      ),
                      const SizedBox(height: 30),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (categories.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          final first = categories[index * 2];
                          final second = (index * 2 + 1 < categories.length)
                              ? categories[index * 2 + 1]
                              : null;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _categoryItem(
                                    first['image']!,
                                    first['name']!,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: second != null
                                      ? _categoryItem(second['image']!, second['name']!)
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _categoryItem(String imagePath, String name) {
    _isHovered.putIfAbsent(name, () => false);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered[name] = true),
      onExit: (_) => setState(() => _isHovered[name] = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 250),
        scale: _isHovered[name]! ? 1.03 : 1.0,
        curve: Curves.easeInOut,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProductPage(
                    categoryName: name,
                    categoryImage: imagePath,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.05),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    Hero(
                      tag: name,
                      child: Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.55),
                              Colors.black.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Mallong',
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              offset: Offset(1, 1),
                              blurRadius: 3,
                            ),
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
