import 'package:shared_preferences/shared_preferences.dart';

/// Guarda a sessão no aparelho.
/// É o mesmo código que estava no main.dart: ainda em texto puro (corrigido na etapa 2).
class AuthLocalDataSource {
  Future<void> save({required String token, required String email}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('email', email);
  }

  Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> readEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
