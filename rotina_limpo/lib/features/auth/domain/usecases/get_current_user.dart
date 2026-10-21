import 'package:rotina_limpo/features/auth/domain/entities/app_user.dart';
import 'package:rotina_limpo/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  GetCurrentUser(this._repository);

  final AuthRepository _repository;

  Future<AppUser?> call() => _repository.currentUser();
}
