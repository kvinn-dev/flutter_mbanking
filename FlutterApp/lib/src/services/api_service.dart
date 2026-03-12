import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  ApiService() {
    // Add interceptor to include Token in headers
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        // Optional: Handle 401 Unauthorized globally
        return handler.next(e);
      },
    ));
  }

  Future<Response> login(String email, String password) async {
    return await _dio.post('/login', data: {
      'email': email,
      'password': password,
    });
  }

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
