import 'package:flutter_test/flutter_test.dart';
import 'package:rotina/core/failure.dart';
import 'package:rotina/features/auth/domain/usecases/login.dart';

import '../../fakes.dart';

void main() {
  late Login login;

  setUp(() {
    login = Login(FakeAuthRepository());
  });

  test('rejeita e-mail inválido', () async {
    await expectLater(login('sem-arroba', '123456'), throwsA(isA<Failure>()));
  });

  test('rejeita senha com menos de 6 caracteres', () async {
    await expectLater(login('ana@email.com', '123'), throwsA(isA<Failure>()));
  });

  test('retorna o usuário quando os dados são válidos', () async {
    final user = await login('  ana@email.com ', '123456');
    expect(user.email, 'ana@email.com');
  });
}
