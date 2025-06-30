import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final Function(String) onNavItemSelected;

  const Navbar({super.key, required this.onNavItemSelected});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  String _hoveredItem = "";

  final List<String> navItems = [
    "Home",
    "About",
    "Menu",
    "Contact",
    "Categories",
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment:
            isMobile ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        children: [
          // Left: Hamburger icon or Logo
          if (isMobile)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          else
            Row(
              children: [
                Image.asset(
                  'asset/photos/logo2-removebg-preview.png',
                  height: 60,
                ),
                const SizedBox(width: 40),
                ..._buildNavItems(["Home", "About"]),
              ],
            ),

          // Right side (only for non-mobile)
          if (!isMobile)
            Row(
              children: _buildNavItems(["Menu", "Contact"]),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(List<String> items) {
    return items.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _navItem(item),
      );
    }).toList();
  }

  Widget _navItem(String title) {
    bool isHovered = _hoveredItem == title;

    return GestureDetector(
      onTap: () => widget.onNavItemSelected(title),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoveredItem = title),
        onExit: (_) => setState(() => _hoveredItem = ""),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          transform: isHovered
              ? (Matrix4.identity()..translate(0, -2))
              : Matrix4.identity(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isHovered ? FontWeight.w700 : FontWeight.w500,
                  color: isHovered ? Colors.white : Colors.grey[300],
                  fontFamily: 'Mallong',
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isHovered ? 40 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
