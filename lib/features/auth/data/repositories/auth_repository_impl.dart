import 'package:rotina/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:rotina/features/auth/data/datasources/fake_auth_remote_datasource.dart';
import 'package:rotina/features/auth/domain/entities/app_user.dart';
import 'package:rotina/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._local);

  final FakeAuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  Future<AppUser> login(String email, String password) async {
    final token = await _remote.login(email, password);
    await _local.save(token: token, email: email);
    return AppUser(email: email);
  }

  @override
  Future<AppUser?> currentUser() async {
    final token = await _local.readToken();
    final email = await _local.readEmail();
    if (token == null || email == null) return null;
    return AppUser(email: email);
  }

  @override
  Future<void> logout() => _local.clear();
}
