import 'package:flutter/material.dart';
import 'package:best_bakes/widgets/navbar.dart';
import 'package:best_bakes/pages/categoryproductpage.dart';
import 'package:flutter/rendering.dart';

class ProductGalleryPage extends StatefulWidget {
  const ProductGalleryPage({super.key});

  @override
  _ProductGalleryPageState createState() => _ProductGalleryPageState();
}

class _ProductGalleryPageState extends State<ProductGalleryPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showHeaderAndBackButton = true;

  final GlobalKey _headerKey = GlobalKey();
  final GlobalKey _categoriesKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse && _showHeaderAndBackButton) {
        setState(() => _showHeaderAndBackButton = false);
      } else if (direction == ScrollDirection.forward && !_showHeaderAndBackButton) {
        setState(() => _showHeaderAndBackButton = true);
      }
    });
  }

  void _onNavItemSelected(String title) {
    final sectionMap = {
      "Home": _headerKey,
      "Categories": _categoriesKey,
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
    final categories = [
      {'image': 'asset/photos/freshcreamcakes/chocolatecake.jpg', 'name': 'Fresh Cream Cakes'},
      {'image': 'asset/photos/juicesandshakes/chocolateshake.jpg', 'name': 'Juices & Shakes'},
      {'image': 'asset/photos/gifthampersandsweetbox/birthdaysweetbox.jpg', 'name': 'Gift Hampers & Sweet Box'},
      {'image': 'asset/photos/snacks/chickenburger.jpg', 'name': 'Snacks'},
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/photos/backgrnd1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                expandedHeight: 80,
                floating: true,
                pinned: true,
                flexibleSpace: Navbar(
                  onNavItemSelected: _onNavItemSelected,
                ),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: _showHeaderAndBackButton ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          iconSize: 24,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Browse By Category',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Mallong',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Home/Top Section
                  Container(
                    key: _headerKey,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Welcome to the Product Gallery!',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: 'Mallong',
                      ),
                    ),
                  ),

                  // Categories Section with more space
                  Expanded(
                    child: Container(
                      key: _categoriesKey,
                      padding: const EdgeInsets.only(top: 20),
                      child: LayoutBuilder(
                        builder: (context, constraints) {

                          return GridView.builder(
                            itemCount: categories.length,
                            padding: EdgeInsets.zero,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 1.8,
                            ),
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return _categoryItem(category['image']!, category['name']!);
                            },
                          );
                        },
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

  Widget _categoryItem(String imagePath, String name) {
    return InkWell(
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Mallong',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
