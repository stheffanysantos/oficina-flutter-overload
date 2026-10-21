import 'package:rotina_limpo/features/auth/domain/repositories/auth_repository.dart';

class Logout {
  Logout(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}
