import 'package:flutter/foundation.dart';
import 'package:rotina/core/failure.dart';
import 'package:rotina/features/auth/domain/entities/app_user.dart';
import 'package:rotina/features/auth/domain/usecases/get_current_user.dart';
import 'package:rotina/features/auth/domain/usecases/login.dart';
import 'package:rotina/features/auth/domain/usecases/logout.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel({
    required Login login,
    required Logout logout,
    required GetCurrentUser getCurrentUser,
  })  : _login = login,
        _logout = logout,
        _getCurrentUser = getCurrentUser;

  final Login _login;
  final Logout _logout;
  final GetCurrentUser _getCurrentUser;

  AppUser? user;
  bool initialized = false;
  bool loading = false;
  String? error;

  Future<void> restoreSession() async {
    try {
      user = await _getCurrentUser();
    } catch (_) {
      user = null;
    }
    initialized = true;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      user = await _login(email, password);
    } on Failure catch (e) {
      error = e.message;
    } catch (_) {
      error = 'Algo deu errado. Tente novamente.';
    }
    loading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _logout();
    user = null;
    error = null;
    notifyListeners();
  }
}
