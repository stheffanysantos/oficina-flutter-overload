import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rotina_limpo/core/di.dart';
import 'package:rotina_limpo/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:rotina_limpo/features/tasks/presentation/view_model/tasks_view_model.dart';
import 'package:rotina_limpo/features/tasks/presentation/widgets/tasks_section.dart';
import 'package:rotina_limpo/features/weather/presentation/view_model/weather_view_model.dart';
import 'package:rotina_limpo/features/weather/presentation/widgets/weather_card.dart';

/// Segunda tela: junta as features Clima e Tarefas.
/// A tela só compõe widgets; não tem regra de negócio nem rede.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = context.watch<AuthViewModel>().user?.email ?? '';
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TasksViewModel>(
          create: (_) => sl<TasksViewModel>()..load(),
        ),
        ChangeNotifierProvider<WeatherViewModel>(
          create: (_) => sl<WeatherViewModel>()..load(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rotina+'),
          actions: [
            IconButton(
              tooltip: 'Sair',
              icon: const Icon(Icons.logout),
              onPressed: () => context.read<AuthViewModel>().signOut(),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Olá, $email'),
              ),
            ),
            const WeatherCard(),
            const Expanded(child: TasksSection()),
          ],
        ),
      ),
    );
  }
}
