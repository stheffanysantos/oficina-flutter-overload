import 'package:rotina/core/failure.dart';
import 'package:rotina/features/auth/domain/entities/app_user.dart';
import 'package:rotina/features/auth/domain/repositories/auth_repository.dart';

class Login {
  Login(this._repository);

  final AuthRepository _repository;

  /// A mesma validação que estava na tela de login (reforçada na etapa 2).
  Future<AppUser> call(String email, String password) async {
    if (!email.contains('@')) {
      throw const Failure('Informe um e-mail válido');
    }
    return _repository.login(email, password);
  }
}
