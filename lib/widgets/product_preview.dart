import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../pages/productpreview_page.dart';

class ProductPreview extends StatelessWidget {
  const ProductPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'image': 'asset/photos/sourdough.jpg',
        'name': 'Sourdough',
        'price': '£1.00',
        'weight': '390g'
      },
      {
        'image': 'asset/photos/wheatbread.jpg',
        'name': 'Whole Wheat',
        'price': '£1.10',
        'weight': '310g'
      },
      {
        'image': 'asset/photos/puffpastry.jpg',
        'name': 'Puff Pastry',
        'price': '£2.00',
        'weight': '410g'
      },
      {
        'image': 'asset/photos/seedbagel.jpg',
        'name': 'Seed Bagel',
        'price': '£1.00',
        'weight': '390g'
      },
      {
        'image': 'asset/photos/plainbagel.jpg',
        'name': 'Plain Bagel',
        'price': '£1.00',
        'weight': '340g'
      },
      {
        'image': 'asset/photos/doughnut.jpg',
        'name': 'Doughnut',
        'price': '£1.00',
        'weight': '410g'
      },
      {
        'image': 'asset/photos/bunchbread.jpg',
        'name': 'Bunch Bread',
        'price': '£1.00',
        'weight': '390g'
      },
      {
        'image': 'asset/photos/grillsalad.jpg',
        'name': 'Grill Salad',
        'price': '£3.00',
        'weight': '390g'
      },
    ];

    bool isMobile = MediaQuery.of(context).size.width < 600;

    return SizedBox(
      height: 800,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: isMobile ? 20 : 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                text: 'Customer ',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mallong',
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: 'Favourites',
                    style: TextStyle(color: Colors.amber),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Product Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 380,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                enlargeCenterPage: true,
                viewportFraction: isMobile ? 0.85 : 0.28,
                enableInfiniteScroll: true,
              ),
              items: products.map((product) {
                return _productItem(
                  context: context,
                  imagePath: product['image']!,
                  name: product['name']!,
                  price: product['price']!,
                  weight: product['weight']!,
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            // View All Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductGalleryPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'View All',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productItem({
    required BuildContext context,
    required String imagePath,
    required String name,
    required String price,
    required String weight,
  }) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: isMobile ? 240 : 270,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 380, // match CarouselSlider height
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mallong',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Mallong',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.scale, color: Colors.grey, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          weight,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: 'Mallong',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () {
                          showProductDetailsDialog(
                              context, imagePath, name, price, weight);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 6,
                          backgroundColor: Colors.amber,
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showProductDetailsDialog(
    BuildContext context,
    String imagePath,
    String name,
    String price,
    String weight,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: 320,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mallong',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.attach_money,
                            size: 18, color: Colors.amber),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.scale, size: 16, color: Colors.grey),
                        Text(
                          weight,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "OK",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
