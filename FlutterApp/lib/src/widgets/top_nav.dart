import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopNav extends StatelessWidget {
  const TopNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: 14,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// LOGO TEXT
          Text.rich(
            TextSpan(
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
              children: const [
                TextSpan(
                  text: "my",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                TextSpan(
                  text: "BCA",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),

          /// ICONS
          Row(
            children: const [
              Icon(
                Icons.headset_mic_outlined,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 12),
              Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 12),
              Icon(
                Icons.logout,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
