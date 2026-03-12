import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_wallet_app/src/providers/wallet_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

// State definition for Auth
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? errorMessage;

  AuthState({
    this.isAuthenticated = false,
    this.isLoading = true,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // Reset error if not provided
    );
  }
}

// Logic for Authentication
class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService _apiService;

  AuthNotifier(this._apiService) : super(AuthState()) {
    checkLoginStatus();
  }

  // Check if token exists in local storage
  Future<void> checkLoginStatus() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token != null && token.isNotEmpty) {
        // Optionally: Verify token validity with an API call here
        state = state.copyWith(isAuthenticated: true, isLoading: false);
      } else {
        state = state.copyWith(isAuthenticated: false, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isAuthenticated: false, isLoading: false);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final response = await _apiService.login(email, password);
      final data = response.data;
      
      if (data != null && data['token'] != null) {
        // Save Token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['token']);
        
        // Save User Name for immediate display if needed
        if (data['name'] != null) {
          await prefs.setString('user_name', data['name']);
        }

        state = state.copyWith(isAuthenticated: true, isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false, 
          errorMessage: 'Invalid response from server'
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        errorMessage: 'Login failed. Please check your credentials.'
      );
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_name');
    state = state.copyWith(isAuthenticated: false);
  }
}

// Provider definition
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(apiServiceProvider));
});
