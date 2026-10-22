import 'package:rotina/core/failure.dart';
import 'package:rotina/features/auth/domain/entities/app_user.dart';
import 'package:rotina/features/auth/domain/repositories/auth_repository.dart';

class Login {
  Login(this._repository);

  final AuthRepository _repository;

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Valida a entrada (OWASP M4) antes de chamar o repositório.
  Future<AppUser> call(String email, String password) async {
    final cleanEmail = email.trim();
    if (!_emailRegex.hasMatch(cleanEmail)) {
      throw const Failure('Informe um e-mail válido');
    }
    if (password.length < 6) {
      throw const Failure('A senha deve ter ao menos 6 caracteres');
    }
    return _repository.login(cleanEmail, password);
  }
}
