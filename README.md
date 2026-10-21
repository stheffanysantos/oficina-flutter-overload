# Clean Architecture em Apps Mobile com Flutter

Material da oficina **"Clean Architecture em Apps Mobile com Flutter: como tratar o feature overload com camadas, segurança e testes"** (SEMPESq 2026).

O app é o **Rotina+**: login falso, clima do dia e lista de tarefas. Ele existe em duas versões com o mesmo comportamento:

| Pasta | O que é |
|---|---|
| `rotina_bagunca/` | Tudo em um único arquivo (feature overload) |
| `rotina_limpo/` | Clean Architecture, segurança e testes |

## Branches da prática

Cada branch é um ponto de partida completo e independente (o app fica na raiz). Se você se perder durante a prática, troque de branch e continue.

| Branch | Conteúdo |
|---|---|
| `etapa-0-bagunca` | Ponto de partida: o app em um único `main.dart` |
| `etapa-1-camadas` | Separação em `domain`, `data` e `presentation`, por feature |
| `etapa-2-seguranca` | Armazenamento seguro, chave fora do código, validação de entrada e logs limpos |
| `etapa-3-testes` | Testes unitários, de ViewModel e de widget (igual ao `rotina_limpo/`) |

Os commits de cada branch seguem a ordem da prática. Use `git log --oneline` para ver os passos.

```bash
git clone <url-do-repositorio>
cd <pasta>
git switch etapa-0-bagunca
flutter create . --project-name rotina_bagunca --platforms=android,ios
rm test/widget_test.dart
flutter pub get
flutter run
```

> Nas branches `etapa-1` e `etapa-2`, use `--project-name rotina_limpo`, apague o `test/widget_test.dart` gerado pelo `flutter create` e rode com `--dart-define=API_KEY=chave_de_demonstracao` a partir da etapa 2.

## Senha de demonstração
Qualquer e-mail válido com a senha `123456`.
