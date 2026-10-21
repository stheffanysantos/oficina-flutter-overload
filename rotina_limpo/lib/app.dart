import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rotina_limpo/core/di.dart';
import 'package:rotina_limpo/features/auth/presentation/pages/login_page.dart';
import 'package:rotina_limpo/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:rotina_limpo/features/home/presentation/pages/home_page.dart';

class RotinaApp extends StatelessWidget {
  const RotinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(
      create: (_) => sl<AuthViewModel>()..restoreSession(),
      child: MaterialApp(
        title: 'Rotina+',
        theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
        home: const AuthGate(),
      ),
    );
  }
}

/// Decide qual tela mostrar: carregando, login ou home.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    if (!auth.initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return auth.user == null ? const LoginPage() : const HomePage();
  }
}
