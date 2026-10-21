import 'package:rotina_limpo/features/auth/domain/entities/app_user.dart';

abstract interface class AuthRepository {
  Future<AppUser> login(String email, String password);
  Future<AppUser?> currentUser();
  Future<void> logout();
}
