import 'package:flutter/material.dart';
import 'profile.dart';
import 'result.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF1EFEA);
    const navColor = Color(0xFFB8F57C);
    const iconColor = Color(0xFF0A2418);

    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 68,
        width: 68,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: navColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SoilTechResultsScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.print,
            size: 28,
            color: iconColor,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: navColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.home,
                    size: 34,
                    color: iconColor,
                  ),
                ),
              ),
              const SizedBox(width: 52),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.person,
                    size: 34,
                    color: iconColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}