import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../services/api_service.dart';

// 1. Model State untuk menyimpan data dompet
class WalletState {
  final double balance;
  final String accountNumber;
  final List<dynamic> transactions;
  final bool isLoading;

  WalletState({
    this.balance = 0,
    this.accountNumber = '-',
    this.transactions = const [],
    this.isLoading = false,
  });

  WalletState copyWith({
    double? balance,
    String? accountNumber,
    List<dynamic>? transactions,
    bool? isLoading,
  }) {
    return WalletState(
      balance: balance ?? this.balance,
      accountNumber: accountNumber ?? this.accountNumber,
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// 2. Provider untuk API Service
final apiServiceProvider = Provider((ref) => ApiService());

// 3. Provider Utama yang akan dipanggil di UI
final walletProvider = StateNotifierProvider<WalletNotifier, WalletState>((ref) {
  return WalletNotifier(ref.read(apiServiceProvider));
});

// 4. Logic Notifier (Penghubung API -> State)
class WalletNotifier extends StateNotifier<WalletState> {
  final ApiService _apiService;

  WalletNotifier(this._apiService) : super(WalletState()) {
    // Otomatis fetch data saat pertama kali dipanggil
    fetchWalletData();
  }

  Future<void> fetchWalletData() async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _apiService.getWalletData();
      final data = response.data;
      
      // Konversi data dari backend
      // Prisma Decimal biasanya dikirim sebagai string di JSON, jadi perlu di-parse
      double parsedBalance = 0.0;
      if (data['balance'] is String) {
        parsedBalance = double.tryParse(data['balance']) ?? 0.0;
      } else if (data['balance'] is num) {
        parsedBalance = (data['balance'] as num).toDouble();
      }

      state = state.copyWith(
        balance: parsedBalance,
        accountNumber: data['accountNumber'] ?? '-',
        transactions: [
           ...?data['sentTransactions'],
           ...?data['receivedTransactions']
        ]..sort((a, b) => b['createdAt'].compareTo(a['createdAt'])), // Urutkan transaksi terbaru
        isLoading: false,
      );
    } catch (e) {
      print("Error fetching wallet data: $e");
      state = state.copyWith(isLoading: false);
    }
  }
}
