import 'package:f5_billion/constants/app_colors.dart';
import 'package:f5_billion/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:sizer/sizer.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      currentIndex: selectedIndex,
      onTap: (index) {
        // 2. Switch to the corresponding route using context.go
        switch (index) {
          case 0:
            context.go('/home-screen');
            break;
          case 1:
            context.go('/order-history');
            break;
          case 2:
            context.go('/my-cart');
            break;
          case 3:
            context.go('/profile');
            break;
        }
      },
      selectedLabelStyle: labelTextStyle.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: labelTextStyle,
      selectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(AppImages.homeIcon, 0, selectedIndex),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(AppImages.bidIcon, 1, selectedIndex),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(AppImages.cartIcon, 2, selectedIndex),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(AppImages.profileIcon, 3, selectedIndex),
          label: 'Profile',
        ),
      ],
    );
  }

  /// Figure out which tab to highlight based on the current route location
  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home-screen')) return 0;
    if (location.startsWith('/order-history')) return 1;
    if (location.startsWith('/my-cart')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  /// Build an SVG icon, coloring it based on whether it's selected
  Widget _buildIcon(String assetName, int index, int selectedIndex) {
    final isSelected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          isSelected ? Colors.black : Colors.grey,
          BlendMode.srcIn,
        ),
        child: SvgPicture.asset(assetName, width: 20.sp, height: 20.sp),
      ),
    );
  }

  static const labelTextStyle = TextStyle(fontSize: 14);
}
