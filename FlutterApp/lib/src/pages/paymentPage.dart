import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _favoriteMenus = [
    {'icon': Icons.bolt, 'title': 'PLN'},
    {'icon': Icons.phone_android, 'title': 'Mobile Data'},
    {'icon': Icons.phone, 'title': 'Phone Credit'},
    {'icon': Icons.account_balance_wallet, 'title': 'e-Wallet'},
    {'icon': Icons.school, 'title': 'Education'},
    {'icon': Icons.volunteer_activism, 'title': 'Donasi & Zakat'},
    {'icon': Icons.public, 'title': 'Roaming'},
  ];

  final List<Map<String, dynamic>> _telecomMenus = [
    {'icon': Icons.phone_android, 'title': 'Mobile Data'},
    {'icon': Icons.phone, 'title': 'Phone Credit'},
    {'icon': Icons.wifi, 'title': 'Telkom/Indihome'},
    {'icon': Icons.phone_in_talk, 'title': 'Post Paid'},
    {'icon': Icons.sim_card, 'title': 'eSIM'},
    {'icon': Icons.public, 'title': 'Roaming'},
  ];

  final List<Map<String, dynamic>> _billsMenus = [
    {'icon': Icons.bolt, 'title': 'PLN'},
    {'icon': Icons.water_drop, 'title': 'Water'},
    {'icon': Icons.health_and_safety, 'title': 'BPJS'},
    {'icon': Icons.wifi, 'title': 'Internet & Cable TV'},
  ];

  final List<Map<String, dynamic>> _financeMenus = [
    {'icon': Icons.credit_card, 'title': 'Credit Card'},
    {'icon': Icons.account_balance, 'title': 'Installment'},
    {'icon': Icons.school, 'title': 'Education'},
    {'icon': Icons.health_and_safety, 'title': 'Insurance'},
    {'icon': Icons.trending_up, 'title': 'Investment'},
    {'icon': Icons.money, 'title': 'Loan'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 251, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        title: Text(
          "Payment & Top Up",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        titleSpacing: 0,
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
            Container(
              decoration: BoxDecoration(
                color: LightColor.lightGrey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.search, color: LightColor.bcaBlue),
                  hintText: 'Search',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionMenu('Favorite', _favoriteMenus),
            _buildSectionMenu('Telecommunication', _telecomMenus),
            _buildSectionMenu('Bills', _billsMenus),
            _buildSectionMenu('Finance', _financeMenus),
          ],
        ),
      ),
    );
  }

// Section container
  Widget _buildSectionMenu(String title, List<Map<String, dynamic>> menus) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: LightColor.bcaDarkBlue,
            ),
          ),
          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menus.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 4,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) =>
                _buildHorizontalMenuItem(menus[index]),
          ),
        ],
      ),
    );
  }

  // Menu Item
  Widget _buildHorizontalMenuItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item['title']} - Coming Soon'),
            backgroundColor: LightColor.bcaBlue,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: 0.785398,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 66, 149, 233).withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Transform.rotate(
                angle: -0.785398,
                child: Icon(
                  item['icon'],
                  color: const Color.fromARGB(255, 5, 87, 168),
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 32,
            child: Text(
              item['title'],
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
