import 'package:flutter/material.dart';
import 'package:rider/const/app_colors.dart';

import 'package:rider/screen/pool_screen.dart';
import 'package:rider/screen/active_screens.dart';
import 'package:rider/screen/leads_screen.dart';
import 'package:rider/screen/profile_screen.dart';

class ButtonNavBar extends StatelessWidget {
  const ButtonNavBar({super.key, this.currentIndex = 0});

  final int currentIndex;

  static const List<_NavItemData> _items = <_NavItemData>[
    _NavItemData(label: 'Pool', icon: Icons.inventory_2_outlined),
    _NavItemData(label: 'Active', icon: Icons.near_me_outlined),
    _NavItemData(label: 'Leads', icon: Icons.location_on_outlined),
    _NavItemData(label: 'Profile', icon: Icons.person_outline),
  ];

  void _navigateToScreen(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget targetScreen;
    switch (index) {
      case 0:
        targetScreen = const PoolScreen();
        break;
      case 1:
        targetScreen = const ActiveScreens();
        break;
      case 2:
        targetScreen = const LeadsScreen();
        break;
      case 3:
        targetScreen = const ProfileScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetScreen,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 12),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.textColor,
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withValues(alpha: 0.04),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List<Widget>.generate(_items.length, (int index) {
            final _NavItemData item = _items[index];
            final bool isSelected = index == currentIndex;

            return Expanded(
              child: InkWell(
                onTap: () => _navigateToScreen(context, index),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        item.icon,
                        size: 22,
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.navBarColor,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.navBarColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
