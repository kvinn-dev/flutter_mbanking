import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class BcaAccountPage extends StatefulWidget {
  const BcaAccountPage({Key? key}) : super(key: key);

  @override
  State<BcaAccountPage> createState() => _BcaAccountPageState();
}

class _BcaAccountPageState extends State<BcaAccountPage> {
  final List<Map<String, String>> _recentAccounts = [
    {'name': 'KEVIN YULIAN PAMUNGKAS', 'account': '734-123-0048'},
    {'name': 'JOHN DOE', 'account': '734-567-8901'},
    {'name': 'JANE SMITH', 'account': '734-234-5678'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.background,
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
          "BCA Account",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // From Account
            const Text(
              "From Account",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: LightColor.bcaBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.account_balance,
                        color: LightColor.bcaBlue),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "734-123-0048",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Rp 15.000.000",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // To Account
            const Text(
              "To Account",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter account number',
                      prefixIcon: const Icon(Icons.person_outline,
                          color: LightColor.bcaBlue),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  const Divider(height: 1),
                  ..._recentAccounts.map((account) => ListTile(
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: LightColor.bcaBlue.withOpacity(0.1),
                          child: Text(
                            account['name']![0],
                            style: const TextStyle(
                                color: LightColor.bcaBlue, fontSize: 12),
                          ),
                        ),
                        title: Text(
                          account['name']!,
                          style: GoogleFonts.inter(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          account['account']!,
                          style: GoogleFonts.inter(
                              fontSize: 11, color: Colors.grey),
                        ),
                        dense: true,
                      )),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Amount
            const Text(
              "Amount (Rp)",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  const Text("Rp",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '0',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Transfer Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: LightColor.bcaBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
