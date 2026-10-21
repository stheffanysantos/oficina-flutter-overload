# rotina_limpo

Rotina+ com **Clean Architecture** (projeto da oficina da SEMPESq 2026).
É a versão corrigida do `rotina_bagunca`: mesmo app, mesmo comportamento.

## Funcionalidades
- **Login falso:** qualquer e-mail válido e a senha `123456`. O token fica no armazenamento seguro.
- **Tela principal:** clima do dia (Open-Meteo) e lista de tarefas (JSONPlaceholder), com adicionar e marcar como concluída.
- **Sair:** apaga a sessão.

## Como rodar
O repositório traz só o código (`lib/` e `test/`). Gere as pastas de plataforma uma vez:

```bash
flutter create . --project-name rotina_limpo --platforms=android,ios
flutter pub get
flutter run --dart-define=API_KEY=chave_de_demonstracao
flutter test
```

Android: para o app de **release** acessar a internet, confira se o arquivo
`android/app/src/main/AndroidManifest.xml` tem
`<uses-permission android:name="android.permission.INTERNET"/>` antes de `<application>`.
(No modo debug isso já funciona.)

## Estrutura
```
lib/
  core/                 failure, env (dart-define), di (get_it)
  features/
    auth/               login falso + sessão
    tasks/              lista de tarefas
    weather/            clima do dia
    home/               segunda tela, só compõe widgets
      <feature>/
        domain/         entities, repositories (interface), usecases
        data/           models, datasources, repositories (implementação)
        presentation/   view_model, pages, widgets
```

Regra de dependência: `presentation` e `data` conhecem o `domain`; o `domain` não conhece Flutter, http nem storage.

## Onde cada tema da oficina aparece
| Tema | Onde ver |
|---|---|
| Regra de negócio no domain | `tasks/domain/usecases/get_tasks.dart` (ordenação) |
| Validação de entrada (OWASP M4) | `auth/domain/usecases/login.dart`, `tasks/domain/usecases/add_task.dart` |
| Armazenamento seguro (M9) | `auth/data/datasources/auth_local_datasource.dart` |
| Chave fora do código (M1) | `core/env.dart` e `tasks/data/datasources/task_remote_datasource.dart` |
| Comunicação segura (M5) | `Uri.https` nos datasources |
| Testes | pasta `test/` (unitários, ViewModel, modelo e widget) |
