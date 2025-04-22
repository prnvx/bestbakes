import 'package:best_bakes/widgets/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:best_bakes/widgets/navbar.dart';

class CategoryProductPage extends StatefulWidget {
  final String categoryName;
  final String categoryImage;

  const CategoryProductPage({
    super.key,
    required this.categoryName,
    required this.categoryImage,
  });

  @override
  _CategoryProductPageState createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showHeaderAndBackButton = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset == 0) {
        setState(() {
          _showHeaderAndBackButton = true;
        });
      } else {
        setState(() {
          _showHeaderAndBackButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onNavItemSelected(String selectedItem) {
    switch (selectedItem) {
      case 'Home':
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      case 'Menu':
        _scrollToTop();
        break;
      case 'Contact':
        break;
    }
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Item added successfully',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 6,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> products = _getCategoryProducts();
    final bool isWideScreen = MediaQuery.of(context).size.width > 800;

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
          // Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Main Content
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                expandedHeight: 80,
                floating: true,
                pinned: false,
                flexibleSpace: Navbar(
                  onNavItemSelected: _onNavItemSelected,
                ),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  // Header with Back Arrow
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
                        Expanded(
                          child: Center(
                            child: Text(
                              widget.categoryName,
                              style: const TextStyle(
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
                  // Product Grid
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: isWideScreen ? 480 : 250, // Adjust grid items based on screen size
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (context, index) {
                        return _buildProductCard(
                          context,
                          products[index]['name']!,
                          products[index]['image']!,
                        );
                      },
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

  // Product card that shows in the grid
  Widget _buildProductCard(BuildContext context, String name, String image) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ProductDetailPopup(name: name, image: image);
          },
        ).then((result) {
          if (result == true) {
            _showSnackBar(context);
          }
        });
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
                image,
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
              bottom: 15,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Mallong',
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to fetch products based on category
  List<Map<String, String>> _getCategoryProducts() {
    if (widget.categoryName == 'Fresh Cream Cakes') {
      return [
        {'name': 'Chocolate Cake', 'image': 'asset/photos/freshcreamcakes/chocolatecake.jpg'},
        {'name': 'Blueberry Cake', 'image': 'asset/photos/freshcreamcakes/blueberrycake.jpg'},
        {'name': 'Coffee Delight Cake', 'image': 'asset/photos/freshcreamcakes/coffeedelightcake.jpg'},
        {'name': 'Spanish Delight Cake', 'image': 'asset/photos/freshcreamcakes/spanishdelightcake.jpg'},
        {'name': 'White Truffle Cake', 'image': 'asset/photos/freshcreamcakes/whitetrufflecake.jpg'},
        {'name': 'Mango Cake', 'image': 'asset/photos/freshcreamcakes/mangocake.jpg'},
        {'name': 'Dry Fruit Cake', 'image': 'asset/photos/freshcreamcakes/dryfruitcake.jpg'},
        {'name': 'Red Velvet Cake', 'image': 'asset/photos/freshcreamcakes/redvelvet.jpg'},
      ];
    } else if (widget.categoryName == 'Juices & Shakes') {
      return [
        {'name': 'Chocolate Shake', 'image': 'asset/photos/juicesandshakes/chocolateshake.jpg'},
        {'name': 'Mango Shake', 'image': 'asset/photos/juicesandshakes/mangoshake.jpg'},
        {'name': 'Strawberry Shake', 'image': 'asset/photos/juicesandshakes/strawberryshake.jpg'},
        {'name': 'Pineapple Juice', 'image': 'asset/photos/juicesandshakes/pineapplejuice.jpg'},
        {'name': 'Orange Juice', 'image': 'asset/photos/juicesandshakes/orangejuice.jpg'},
        {'name': 'Watermelon Juice', 'image': 'asset/photos/juicesandshakes/watermelonjuice.jpg'},
        {'name': 'Apple Juice', 'image': 'asset/photos/juicesandshakes/applejuice.jpg'},
        {'name': 'Sharjah Shake', 'image': 'asset/photos/juicesandshakes/sharjahshake.jpg'},
        {'name': 'Pomegranate Juice', 'image': 'asset/photos/juicesandshakes/pomegranatejuice.jpg'},
        {'name': 'Chikkoo Shake', 'image': 'asset/photos/juicesandshakes/chikkushake.jpg'},
        {'name': 'Grape Juice', 'image': 'asset/photos/juicesandshakes/grapeshake.jpg'},
        {'name': 'Avocado Shake', 'image': 'asset/photos/juicesandshakes/avocadoshake.jpg'},
        {'name': 'Milk Shake', 'image': 'asset/photos/juicesandshakes/milkshake.jpg'},
        {'name': 'Guava Juice', 'image': 'asset/photos/juicesandshakes/guavajuice.jpg'},
        {'name': 'Mango Juice', 'image': 'asset/photos/juicesandshakes/mangojuice.jpg'},
      ];
    } else if (widget.categoryName == 'Gift Hampers & Sweet Box') {
      return [
        {'name': 'Birthday Sweet Box', 'image': 'asset/photos/gifthampersandsweetbox/birthdaysweetbox.jpg'},
        {'name': 'Festival Gift Hamper', 'image': 'asset/photos/gifthampersandsweetbox/festivalsweetbox.jpg'},
        {'name': 'Plum Cake Box', 'image': 'asset/photos/gifthampersandsweetbox/plumcakebox.jpg'},
        {'name': 'Kerala Sweet Box', 'image': 'asset/photos/gifthampersandsweetbox/keralasweetbox.jpg'},
        {'name': 'Diwali Gift Hamper', 'image': 'asset/photos/gifthampersandsweetbox/diwalisweetbox.jpg'},
        {'name': 'Christmas Gift Box', 'image': 'asset/photos/gifthampersandsweetbox/christmascakebox.jpg'},
      ];
    } else if (widget.categoryName == 'Snacks') {
      return [
        {'name': 'Chicken Burger', 'image': 'asset/photos/snacks/chickenburger.jpg'},
        {'name': 'Veg Sandwich', 'image': 'asset/photos/snacks/vegsandwich.jpg'},
        {'name': 'Chicken Bun', 'image': 'asset/photos/snacks/chickenbun.jpg'},
        {'name': 'Chicken Puffs', 'image': 'asset/photos/snacks/chickenpuffs.jpeg'},
        {'name': 'Chicken Sandwich', 'image': 'asset/photos/snacks/chickensandwich.jpg'},
        {'name': 'Custard Bun', 'image': 'asset/photos/snacks/custardbun.jpg'},
        {'name': 'Veg Burger', 'image': 'asset/photos/snacks/vegburger.jpg'},
        {'name': 'Egg Bun', 'image': 'asset/photos/snacks/eggbun.jpg'},
      ];
    }
    return [];
  }
}
