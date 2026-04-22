import 'package:flutter/material.dart';
import 'profile.dart';
import 'result.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF3F1EC);
    const navColor = Color(0xFFB8F57C);
    const iconColor = Color(0xFF0A2418);

    return Scaffold(
      backgroundColor: bgColor,
      body: const SafeArea(
        child: SizedBox.expand(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 74,
        height: 74,
        decoration: const BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: navColor,
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SoilTechResultsScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              size: 30,
              color: iconColor,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 14),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: navColor,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.home_rounded,
                        size: 38,
                        color: iconColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chat_bubble_rounded,
                        size: 34,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 70),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.history_rounded,
                        size: 38,
                        color: iconColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.person_rounded,
                        size: 36,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}