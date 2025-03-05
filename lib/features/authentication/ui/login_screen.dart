import 'dart:ui';

import 'package:f5_billion/constants/app_images.dart';
import 'package:f5_billion/features/authentication/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _pageController = PageController();
  bool _allowSwipe = false;

  void _navigateToRegister() {
    setState(() {
      _allowSwipe = true;
    });
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _navigateToLogin() {
    setState(() {
      _allowSwipe = false; // Disable swipe again
    });
    _pageController.animateToPage(
      0, // Go back to Login Form
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand, // Make sure the image fills the screen
        children: [
          // Background Image
          Image.asset(
            AppImages.authBg, // Replace with your actual image asset path
            fit: BoxFit.cover, // Ensures the image covers the whole screen
          ),

          // Optional Blur Effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ), // Adjust blur intensity
              child: Container(color: Colors.black.withAlpha(5)),
            ),
          ),

          // PageView with Forms
          PageView(
            controller: _pageController,
            physics:
                _allowSwipe
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
            children: [
              LoginForm(onRegisterClick: _navigateToRegister),
              // RegisterForm(onLoginClick: _navigateToLogin),
            ],
          ),
        ],
      ),
    );
  }
}
