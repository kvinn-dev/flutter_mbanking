import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final List<Map<String, dynamic>> _transferMenus = [
    {
      'icon': Icons.account_balance,
      'title': 'BCA Account',
      'subtitle': 'Transfer funds to other BCA accounts',
      'route': '/transfer/bca-account'
    },
    {
      'icon': Icons.account_balance_wallet,
      'title': 'Other Banks',
      'subtitle': 'Transfer funds to other domestic banks',
      'route': '/transfer/other-banks'
    },
    {
      'icon': Icons.currency_exchange,
      'title': 'Forex to Other Banks',
      'subtitle':
          'Transfer forex funds to other bank accounts, domestic and overseas',
      'route': '/transfer/forex'
    },
    {
      'icon': Icons.location_on,
      'title': 'Proxy Address',
      'subtitle': 'Transfer funds via Proxy Address',
      'route': '/transfer/proxy-address'
    },
    {
      'icon': Icons.account_balance,
      'title': 'Virtual Account',
      'subtitle': 'Transfer funds to BCA Virtual Accounts',
      'route': '/transfer/virtual-account'
    },
    {
      'icon': Icons.account_balance_wallet,
      'title': 'Sakuku',
      'subtitle': 'Transfer funds to Sakuku number',
      'route': '/transfer/sakuku'
    },
    {
      'icon': Icons.card_giftcard,
      'title': 'BagiBagi',
      'subtitle': 'Gift money to friends and family',
      'route': '/transfer/bagi-bagi'
    },
    {
      'icon': Icons.import_export,
      'title': 'Import Beneficiary List',
      'subtitle': 'Import from m-BCA and KlikBCA Individu',
      'route': '/transfer/import-beneficiary'
    },
    {
      'icon': Icons.description,
      'title': 'Underlying Documents',
      'subtitle':
          'List of your underlying documents to make Forex transactions',
      'route': '/transfer/underlying-documents'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 251, 255),
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
          "Transfer",
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
      body: Column(
        children: [
          // Hapus Search Bar → langsung List Menu
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _transferMenus.length,
              itemBuilder: (context, index) {
                final menu = _transferMenus[index];
                return _buildTransferMenuItem(menu);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferMenuItem(Map<String, dynamic> menu) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8), // jarak antar menu
      padding: const EdgeInsets.symmetric(
          horizontal: 16), // padding dalam container
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
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, menu['route']);
        },
        contentPadding: EdgeInsets.zero, // sudah pakai padding container
        leading: Transform.rotate(
          angle: 0.785398, // 45 derajat
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 66, 149, 233).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Transform.rotate(
              angle: -0.785398, // balikin icon supaya lurus
              child: Icon(
                menu['icon'],
                color: const Color.fromARGB(255, 5, 87, 168),
                size: 24,
              ),
            ),
          ),
        ),
        title: Text(
          menu['title'],
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: LightColor.bcaDarkBlue,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            menu['subtitle'],
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: LightColor.bcaDarkBlue,
        ),
      ),
    );
  }
}
