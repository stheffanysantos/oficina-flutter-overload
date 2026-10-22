# Clean Architecture em Apps Mobile com Flutter

Material da oficina **"Clean Architecture em Apps Mobile com Flutter: como tratar o feature overload com camadas, segurança e testes"** (SEMPESq 2026).

O app é o **Rotina+**: login falso, clima do dia e lista de tarefas. Na oficina ele roda no navegador (Chrome).

## Você está na `etapa-2-seguranca`

As mesmas camadas da etapa 1, agora com quatro correções de segurança (OWASP Mobile Top 10). Cada uma mexe em poucos arquivos, graças às camadas:

| Risco | Correção | Onde |
|---|---|---|
| M9 Armazenamento inseguro | `SharedPreferences` trocado por `flutter_secure_storage` | `auth/data/datasources/auth_local_datasource.dart` e `core/di.dart` |
| M1 Credenciais no código | A chave sai do código e entra por `--dart-define` | `core/env.dart` e `tasks/data/datasources/task_remote_datasource.dart` |
| M4 Validação de entrada | E-mail com expressão regular, senha com 6 caracteres, título com até 80 | `auth/domain/usecases/login.dart` e `tasks/domain/usecases/add_task.dart` |
| M5 e logs | `Uri.https` e nenhum `print` com token ou senha | datasources e `auth/data/repositories/auth_repository_impl.dart` |

Atenção: o `--dart-define` tira a chave do repositório, mas não do app compilado. Segredo de verdade fica no servidor. E, na web, o armazenamento seguro protege menos que o Keychain e o Keystore dos celulares.

```bash
flutter pub get
flutter run -d chrome --dart-define=API_KEY=minha_chave
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
