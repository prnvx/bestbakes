import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 80),
      color: const Color(0xFF121826),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact & Social Media Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMobile)
                    Expanded(
                      flex: 2,
                      child: _contactSection(),
                    ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 1,
                    child: _socialMediaSection(),
                  ),
                  if (isMobile) ...[
                    _contactSection(),
                    const SizedBox(height: 20),
                    _socialMediaSection(),
                  ],
                ],
              ),
              const SizedBox(height: 40),

              // Newsletter Subscription Section
              _newsletterSection(),

              const SizedBox(height: 50),

              // Footer Links & Socials
              _footerLinks(),

              const SizedBox(height: 40),

              // Copyright & Social Icons
              _footerBottom(),
            ],
          );
        },
      ),
    );
  }

  // Contact Us Section
  Widget _contactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contact Us",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 25),
        _contactInfo(Icons.email, "contact@bistrobakery.com"),
        _contactInfo(Icons.phone, "+91 98765 43210"),
        _contactInfo(Icons.location_on, "Leicester Street, UK"),
      ],
    );
  }

  // Social Media Section
  Widget _socialMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Follow Us",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _socialIcon(FontAwesomeIcons.facebook),
            _socialIcon(FontAwesomeIcons.twitter),
            _socialIcon(FontAwesomeIcons.instagram),
            _socialIcon(FontAwesomeIcons.pinterest),
          ],
        ),
      ],
    );
  }

  // Contact Info Styling
  Widget _contactInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 22),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  // Social Icon Styling
  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white12,
            shape: BoxShape.circle,
          ),
          child: FaIcon(
            icon,
            color: Colors.amber,
            size: 20,
          ),
        ),
      ),
    );
  }

  // Newsletter Subscription
  Widget _newsletterSection() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Subscribe to our Newsletter",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ),
          SizedBox(
            width: 280,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your email",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Subscribe",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Footer Links Section
  Widget _footerLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _footerColumn("Merchandise", ["T-shirts", "Cups", "Mugs"]),
        _footerColumn("Franchise", ["Coffee Outlets", "Coffee Vending"]),
        _footerColumn("About Us", ["Promotions", "Legal", "Careers"]),
      ],
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              item,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ),
      ],
    );
  }

  // Copyright & Socials
  Widget _footerBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "© 2025 Bistro Bakery. All rights reserved.",
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
        Row(
          children: [
            _socialIcon(FontAwesomeIcons.facebook),
            _socialIcon(FontAwesomeIcons.twitter),
            _socialIcon(FontAwesomeIcons.instagram),
            _socialIcon(FontAwesomeIcons.pinterest),
          ],
        ),
      ],
    );
  }
}
