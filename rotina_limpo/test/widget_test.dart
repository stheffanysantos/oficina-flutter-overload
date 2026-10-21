import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rotina_limpo/features/auth/domain/usecases/get_current_user.dart';
import 'package:rotina_limpo/features/auth/domain/usecases/login.dart';
import 'package:rotina_limpo/features/auth/domain/usecases/logout.dart';
import 'package:rotina_limpo/features/auth/presentation/pages/login_page.dart';
import 'package:rotina_limpo/features/auth/presentation/view_model/auth_view_model.dart';

import 'fakes.dart';

void main() {
  testWidgets('LoginPage mostra erro ao entrar sem preencher', (tester) async {
    final repo = FakeAuthRepository();
    final vm = AuthViewModel(
      login: Login(repo),
      logout: Logout(repo),
      getCurrentUser: GetCurrentUser(repo),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider<AuthViewModel>.value(
        value: vm,
        child: const MaterialApp(home: LoginPage()),
      ),
    );

    await tester.tap(find.text('Entrar'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Informe um e-mail válido'), findsOneWidget);
  });
}
