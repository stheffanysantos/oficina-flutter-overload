import 'package:rotina_limpo/core/failure.dart';

/// Servidor de autenticação simulado, só para fins de aprendizado.
/// Aceita qualquer e-mail com a senha de demonstração.
class FakeAuthRemoteDataSource {
  static const demoPassword = '123456';

  Future<String> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (password != demoPassword) {
      throw const Failure('E-mail ou senha incorretos');
    }
    return 'fake-token-${DateTime.now().millisecondsSinceEpoch}';
  }
}
