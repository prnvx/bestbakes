import 'package:best_bakes/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool isSignUp = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              SingleChildScrollView(
                child: _authSection(),
              ),
              const SizedBox(height: 50),
              _footerLinks(),
              const SizedBox(height: 40),
              _footerBottom(),
            ],
          );
        },
      ),
    );
  }

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
            _socialIcon(FontAwesomeIcons.facebook, 'https://www.facebook.com/NationalGeographic'),
            _socialIcon(FontAwesomeIcons.twitter, 'https://twitter.com/Twitter'),
            _socialIcon(FontAwesomeIcons.instagram, 'https://www.instagram.com/natgeo'),
            _socialIcon(FontAwesomeIcons.pinterest, 'https://www.pinterest.com/'),
          ],
        ),
      ],
    );
  }

  Widget _contactInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 22),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open $url')),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
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

  Widget _authSection() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isSignUp ? "Sign Up" : "Sign In",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 20),
            if (isSignUp) ...[
              _textField(controller: nameController, hint: "Name", validator: (value) => value!.isEmpty ? 'Enter name' : null),
              const SizedBox(height: 10),
              _textField(controller: phoneController, hint: "Phone Number", validator: (value) => value!.isEmpty ? 'Enter phone' : null),
              const SizedBox(height: 10),
            ],
            _textField(controller: emailController, hint: "Email", validator: (value) => value!.isEmpty ? 'Enter email' : null),
            const SizedBox(height: 10),
            _textField(controller: passwordController, hint: "Password", obscure: true, validator: (value) => value!.isEmpty ? 'Enter password' : null),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final firebaseService = FirebaseService();
                    if (isSignUp) {
                      String? result = await firebaseService.signUp(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      if (result == null) {
                        setState(() {
                          isSignUp = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sign up successful! Please sign in.')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)),
                        );
                      }
                    } else {
                      String? result = await firebaseService.signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      if (result == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sign in successful!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isSignUp ? "Sign Up" : "Sign In",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSignUp = !isSignUp;
                    });
                  },
                  child: Text(
                    isSignUp ? "Already have an account? Sign In" : "Don’t have an account? Sign Up",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final firebaseService = FirebaseService();
                  String? result = await firebaseService.signInWithGoogle();

                  if (result == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signed in with Google successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                icon: const FaIcon(FontAwesomeIcons.google, size: 20),
                label: const Text("Continue with Google"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

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
            _socialIcon(FontAwesomeIcons.facebook, 'https://www.facebook.com/NationalGeographic'),
            _socialIcon(FontAwesomeIcons.twitter, 'https://twitter.com/Twitter'),
            _socialIcon(FontAwesomeIcons.instagram, 'https://www.instagram.com/natgeo'),
            _socialIcon(FontAwesomeIcons.pinterest, 'https://www.pinterest.com/'),
          ],
        ),
      ],
    );
  }
}
