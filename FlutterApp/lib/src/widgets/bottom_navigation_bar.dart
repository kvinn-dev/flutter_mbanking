import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          /// BACKGROUND NAVBAR
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: LightColor.bcaBlue,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /// HOME
                  _buildItem(
                    icon: _currentIndex == 0
                        ? Icons.home_filled
                        : Icons.home_outlined,
                    label: "Home",
                    index: 0,
                  ),

                  /// ACTIVITY
                  _buildItem(
                    icon: _currentIndex == 1
                        ? Icons.history
                        : Icons.history_outlined,
                    label: "Activity",
                    index: 1,
                  ),

                  const SizedBox(width: 50),

                  /// FOR YOU
                  _buildItem(
                    icon: _currentIndex == 3
                        ? Icons.auto_awesome
                        : Icons.auto_awesome_outlined,
                    label: "For You",
                    index: 3,
                  ),

                  /// ACCOUNT
                  _buildItem(
                    icon: _currentIndex == 4
                        ? Icons.person
                        : Icons.person_outline,
                    label: "Account",
                    index: 4,
                  ),
                ],
              ),
            ),
          ),

          /// FLOATING QRIS BUTTON
          Positioned(
            top: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// DIAMOND SHAPE
                  Transform.rotate(
                    angle: 0.785398, // 45°
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 38, 189, 254),
                            Color.fromARGB(255, 0, 93, 233),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0066FF).withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Transform.rotate(
                        angle: -0.785398, // rotate icon back
                        child: const Center(
                          child: Icon(
                            Icons.qr_code_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// TEXT DI LUAR SHAPE
                  Text(
                    "QRIS",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _currentIndex == 2
                          ? Colors.white
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
