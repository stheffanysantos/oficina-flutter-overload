# Clean Architecture em Apps Mobile com Flutter

Material da oficina **"Clean Architecture em Apps Mobile com Flutter: como tratar o feature overload com camadas, segurança e testes"** (SEMPESq 2026).

O app é o **Rotina+**: login falso, clima do dia e lista de tarefas. Na oficina ele roda no navegador (Chrome).

## Você está na `etapa-0-bagunca`

O ponto de partida: o app inteiro em um único `lib/main.dart` (447 linhas, três telas e nenhuma separação). Ele funciona, mas tem **feature overload**:

- a tela chama a internet, aplica regra de negócio e desenha, tudo junto;
- a regra de ordenar as tarefas aparece copiada em três lugares;
- o token fica em texto puro no `SharedPreferences` e aparece no log;
- a chave de API está escrita no código;
- não há como testar uma regra sem subir a tela e a rede.

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
