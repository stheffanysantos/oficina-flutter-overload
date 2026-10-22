# Clean Architecture em Apps Mobile com Flutter

Material da oficina **"Clean Architecture em Apps Mobile com Flutter: como tratar o feature overload com camadas, segurança e testes"** (SEMPESq 2026).

O app é o **Rotina+**: login falso, clima do dia e lista de tarefas. Na oficina ele roda no navegador (Chrome).

## Você está na `etapa-1-camadas`

O mesmo app, com o mesmo comportamento, separado em camadas e organizado por feature. Nenhuma regra nova: cada trecho do antigo `main.dart` foi para a sua casa.

```
lib/
  main.dart           só liga a injeção de dependência e o app
  app.dart            AuthGate: decide entre login e home
  core/               di.dart (get_it) e failure.dart
  features/
    auth/ tasks/ weather/
      domain/         entities, repositories (interface), usecases
      data/           models, datasources, repositories (implementação)
      presentation/   view_model, pages, widgets
    home/             só junta clima e tarefas na tela
```

Regra de dependência: `presentation` e `data` conhecem o `domain`; o `domain` não conhece Flutter, http nem armazenamento.

**De propósito, os problemas de segurança continuam aqui** (só mudaram de lugar): o token em `SharedPreferences`, a chave `ABC123-SECRETA` no `task_remote_datasource.dart`, os `print` com token e senha e a validação fraca. Eles são corrigidos na `etapa-2-seguranca`.

```bash
flutter pub get
flutter run -d chrome
```

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
