import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0073CF),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.heart),
            label: 'مفضلاتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.building_3),
            label: 'عقاراتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}
