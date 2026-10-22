// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotina+',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const Gate(),
    );
  }
}

class Gate extends StatefulWidget {
  const Gate({super.key});

  @override
  State<Gate> createState() => _GateState();
}

class _GateState extends State<Gate> {
  String? token;
  String? email;
  bool ready = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    email = prefs.getString('email');
    print('token salvo: $token');
    if (!mounted) return;
    setState(() => ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (token == null) {
      return LoginScreen(
        onLogin: (t, e) => setState(() {
          token = t;
          email = e;
        }),
      );
    }
    return HomeScreen(
      email: email ?? '',
      token: token!,
      onLogout: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        if (!mounted) return;
        setState(() {
          token = null;
          email = null;
        });
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLogin});

  final void Function(String token, String email) onLogin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool loading = false;
  String? error;

  Future<void> doLogin() async {
    setState(() {
      loading = true;
      error = null;
    });
    // validação e "autenticação" direto na tela
    if (!emailC.text.contains('@')) {
      setState(() {
        loading = false;
        error = 'Informe um e-mail válido';
      });
      return;
    }
    if (passC.text != '123456') {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      setState(() {
        loading = false;
        error = 'E-mail ou senha incorretos';
      });
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final token = 'fake-token-${DateTime.now().millisecondsSinceEpoch}';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('email', emailC.text);
    print('login ok, token: $token, senha: ${passC.text}');
    widget.onLogin(token, emailC.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Rotina+',
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Entre para ver suas tarefas',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passC,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: loading ? null : doLogin,
                    child: loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Entrar'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Demonstração: qualquer e-mail válido e a senha 123456',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.email,
    required this.token,
    required this.onLogout,
  });

  final String email;
  final String token;
  final VoidCallback onLogout;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // tarefas
  List<dynamic> tasks = [];
  bool loadingTasks = true;
  String? taskError;
  final taskC = TextEditingController();

  // clima
  String weatherText = '';
  bool loadingWeather = true;
  String? weatherError;

  @override
  void initState() {
    super.initState();
    loadTasks();
    loadWeather();
  }

  Future<void> loadTasks() async {
    try {
      final res = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=8'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'x-api-key': 'ABC123-SECRETA',
        },
      );
      print('GET /todos -> ${res.statusCode} (token ${widget.token})');
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as List<dynamic>;
        data.sort((a, b) =>
            (a['completed'] == true ? 1 : 0).compareTo(b['completed'] == true ? 1 : 0));
        if (!mounted) return;
        setState(() {
          tasks = data;
          loadingTasks = false;
        });
      } else {
        if (!mounted) return;
        setState(() {
          taskError = 'Erro ${res.statusCode}';
          loadingTasks = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        taskError = 'Sem conexão. Verifique sua internet.';
        loadingTasks = false;
      });
    }
  }

  Future<void> loadWeather() async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=-23.55&longitude=-46.63&current=temperature_2m,weather_code'));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        final temp = json['current']['temperature_2m'];
        final code = json['current']['weather_code'];
        String desc;
        if (code == 0) {
          desc = 'Céu limpo';
        } else if (code <= 3) {
          desc = 'Parcialmente nublado';
        } else if (code == 45 || code == 48) {
          desc = 'Neblina';
        } else if (code >= 51 && code <= 67) {
          desc = 'Chuva';
        } else if (code >= 71 && code <= 77) {
          desc = 'Neve';
        } else if (code >= 80 && code <= 82) {
          desc = 'Pancadas de chuva';
        } else if (code >= 95) {
          desc = 'Tempestade';
        } else {
          desc = 'Tempo instável';
        }
        if (!mounted) return;
        setState(() {
          weatherText = 'São Paulo · ${temp.round()}°C · $desc';
          loadingWeather = false;
        });
      } else {
        if (!mounted) return;
        setState(() {
          weatherError = 'Erro ao buscar o clima (${res.statusCode})';
          loadingWeather = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        weatherError = 'Não foi possível carregar o clima';
        loadingWeather = false;
      });
    }
  }

  void addTask() {
    final t = taskC.text.trim();
    if (t.isEmpty) {
      setState(() => taskError = 'Digite um título para a tarefa');
      return;
    }
    if (t.length > 200) {
      setState(() => taskError = 'Título muito grande');
      return;
    }
    setState(() {
      tasks.insert(0, {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': t,
        'completed': false,
      });
      tasks.sort((a, b) =>
          (a['completed'] == true ? 1 : 0).compareTo(b['completed'] == true ? 1 : 0));
      taskError = null;
    });
    taskC.clear();
  }

  void toggleTask(dynamic task) {
    setState(() {
      task['completed'] = !(task['completed'] == true);
      tasks.sort((a, b) =>
          (a['completed'] == true ? 1 : 0).compareTo(b['completed'] == true ? 1 : 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotina+'),
        actions: [
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout),
            onPressed: widget.onLogout,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Olá, ${widget.email}'),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.wb_sunny_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: loadingWeather
                        ? const Text('Carregando clima...')
                        : weatherError != null
                            ? Text(weatherError!)
                            : Text(weatherText),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskC,
                    decoration: const InputDecoration(
                      hintText: 'Nova tarefa',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  tooltip: 'Adicionar',
                  onPressed: addTask,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          if (taskError != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                taskError!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          Expanded(
            child: loadingTasks
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      for (final task in tasks)
                        CheckboxListTile(
                          value: task['completed'] == true,
                          title: Text(
                            task['title'],
                            style: task['completed'] == true
                                ? const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                  )
                                : null,
                          ),
                          onChanged: (_) => toggleTask(task),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
