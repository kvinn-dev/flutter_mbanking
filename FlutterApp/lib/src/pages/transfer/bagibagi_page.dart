import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BagiBagiPage extends StatelessWidget {
  const BagiBagiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          iconSize: 18, // ukuran icon lebih kecil
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero, // hapus padding default IconButton
          constraints: const BoxConstraints(), // hapus batas minimum default
        ),
        titleSpacing: 0, // title langsung nyambung ke icon
        title: Text(
          "BagiBagi",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 7, 73, 139),
                Color.fromARGB(255, 6, 63, 117),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: const Center(child: Text('BagiBagi Page - Coming Soon')),
    );
  }
}
