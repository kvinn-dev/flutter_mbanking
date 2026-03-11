import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double? equivalentValue;
  
  const BalanceCard({
    Key? key, 
    this.balance = 763250000.00,
    this.equivalentValue,
  }) : super(key: key);

  String get formattedBalance {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return format.format(balance);
  }

  @override
  Widget build(BuildContext context) {
    // Return empty container karena kita sudah tidak menggunakan balance card lama
    // Digantikan dengan _bcaIdCard dan _balanceStatus di homepage
    return const SizedBox.shrink();
  }
}