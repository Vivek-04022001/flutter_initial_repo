import 'package:f5_billion/features/home/ui/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';

class BottomNavShell extends StatefulWidget {
  final Widget child;
  const BottomNavShell({super.key, required this.child});

  @override
  State<BottomNavShell> createState() => BottomNavShellState();
}

class BottomNavShellState extends State<BottomNavShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The child's content is the screen from the route array (Home, Orders, etc.)
      body: Stack(
        children: [
          widget.child,
          // if (kycStatus != 1) const FloatingCircularWidget(),
        ],
      ),
      // The persistent bottom nav bar
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}
