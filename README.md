# Clean Architecture em Apps Mobile com Flutter

Material da oficina **"Clean Architecture em Apps Mobile com Flutter: como tratar o feature overload com camadas, segurança e testes"** (SEMPESq 2026).

O app é o **Rotina+**: login falso, clima do dia e lista de tarefas. Na oficina ele roda no navegador (Chrome).

## Você está na `etapa-3-testes`

O código de `lib/` é o mesmo da etapa 2. Esta etapa só acrescenta a pasta `test/`: como o domain não depende de Flutter nem de rede, as regras são testadas em segundos, sem emulador e sem internet.

| Arquivo | O que testa |
|---|---|
| `test/fakes.dart` | Repositórios falsos de tarefas e autenticação |
| `test/features/tasks/get_tasks_test.dart` | Pendentes aparecem antes das concluídas |
| `test/features/tasks/add_task_test.dart` | Título vazio e título grande são recusados |
| `test/features/tasks/tasks_view_model_test.dart` | Estados do ViewModel: sucesso, erro, adicionar e alternar |
| `test/features/auth/login_test.dart` | E-mail inválido e senha curta são recusados |
| `test/features/weather/weather_model_test.dart` | Código do tempo vira o texto certo |
| `test/widget_test.dart` | Tela de login mostra o erro de validação |

```bash
flutter pub get
flutter test
```

Experimente quebrar a regra: em `lib/features/tasks/domain/usecases/get_tasks.dart`, troque para `[...done, ...pending]` e rode `flutter test` de novo. Depois desfaça com `git restore lib`.

## As etapas

Cada branch é um ponto completo do mesmo app. Se você se perder, troque de branch e continue.

| Branch | Conteúdo | Como rodar |
|---|---|---|
| `etapa-0-bagunca` | O app em um único `main.dart` | `flutter run -d chrome` |
| `etapa-1-camadas` | Separação em `domain`, `data` e `presentation`, por feature | `flutter run -d chrome` |
| `etapa-2-seguranca` | Armazenamento seguro, chave fora do código, validação de entrada e logs limpos | `flutter run -d chrome --dart-define=API_KEY=minha_chave` |
| `etapa-3-testes` | Testes de caso de uso, ViewModel, modelo e widget | `flutter test` |

Para trocar de etapa:

```bash
# 1. aperte q no terminal onde o app está rodando
git restore .                 # desfaz as alterações da tarefa (apaga sem perguntar)
git switch etapa-1-camadas    # troca de etapa
flutter pub get               # cada etapa tem seus pacotes
flutter run -d chrome
```

## Senha de demonstração
Qualquer e-mail válido com a senha `123456`.
