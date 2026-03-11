import 'package:dio/dio.dart';

class ApiService {
  // Jika menggunakan Android Emulator, gunakan 10.0.2.2.
  // Jika menggunakan iOS Simulator, gunakan 127.0.0.1 atau localhost.
  // Jika test di HP fisik, gunakan IP Address laptop (misal 192.168.1.x)
  static const String baseUrl = 'http://10.0.2.2:3000';
  
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<Response> getWalletData() async {
    return await _dio.get('/wallet/me');
  }

  Future<Response> transfer(String targetAccount, double amount) async {
    return await _dio.post('/wallet/transfer', data: {
      'toAccount': targetAccount,
      'amount': amount,
    });
  }
}
