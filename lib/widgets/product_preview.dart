import 'package:best_bakes/pages/productpreview_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

    // Get screen width to determine if it's mobile or desktop
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return SizedBox(
      height: 750, // Adjusted height for both mobile and desktop
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: isMobile ? 20 : 60), // Padding adjusted for mobile/desktop
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Section Title
            RichText(
              text: const TextSpan(
                text: 'Customer ',
                style: TextStyle(
                  fontSize: 32,
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
            const SizedBox(height: 25),

            // Horizontal Scrolling Products with Animation
            SizedBox(
              height: 350, // Increased height to avoid content being cut off
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 330, // Adjusted height to match product card
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  viewportFraction: isMobile ? 0.8 : 0.3, // Adjusted for mobile vs desktop
                  enableInfiniteScroll: true,
                ),
                items: products.map((product) {
                  return _productItem(
                    context: context, // Pass context here
                    imagePath: product['image']!,
                    name: product['name']!,
                    price: product['price']!,
                    weight: product['weight']!,
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),

            // "View All" Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductGalleryPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text(
                'View All',
                style: TextStyle(
                    fontSize: 16,
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
    required BuildContext context, // Pass context here
    required String imagePath,
    required String name,
    required String price,
    required String weight,
  }) {
    // Now `context` is available here
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: isMobile ? 200 : 250, // Adjust width for mobile/desktop
      height: 330, // Adjusted height to fit all elements properly
      decoration: BoxDecoration(
        color: const Color(0xFF0E1A2B), // Dark Blue Background
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 140, // Adjusted to fit content properly
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 8), // Reduced padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Product Price
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    fontFamily: 'Mallong',
                  ),
                ),
                const SizedBox(height: 5),

                // Product Name
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Mallong',
                  ),
                ),
                const SizedBox(height: 5),

                // Product Weight
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.scale, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(
                      weight,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Mallong',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Add Button - Wrapped in SizedBox to prevent overflow
                SizedBox(
                  width: double.infinity,
                  height: 40, // Fixed height to avoid stretching
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8), // Reduced padding
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
