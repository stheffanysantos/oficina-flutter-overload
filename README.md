# Clean Architecture em Apps Mobile com Flutter

Material da oficina **"Clean Architecture em Apps Mobile com Flutter: como tratar o feature overload com camadas, segurança e testes"** (SEMPESq 2026).

O app é o **Rotina+**: login falso, clima do dia e lista de tarefas. Na oficina ele roda no navegador (Chrome); você só precisa do Flutter e do Chrome.

## Comece por aqui

A prática acontece nas branches. Clone e vá direto para a primeira etapa:

```bash
git clone https://github.com/stheffanysantos/oficina-flutter-overload
cd oficina-flutter-overload
git switch etapa-0-bagunca
flutter pub get
flutter run -d chrome
```

Para chegar com tudo pronto (e não depender da internet no dia), baixe os pacotes de todas as etapas:

```bash
for b in etapa-0-bagunca etapa-1-camadas etapa-2-seguranca etapa-3-testes; do git switch $b && flutter pub get; done
git switch etapa-0-bagunca
```

## As etapas

Cada branch é um ponto completo do mesmo app, com o projeto na raiz. Se você se perder, troque de branch e continue.

| Branch | Conteúdo | Como rodar |
|---|---|---|
| `etapa-0-bagunca` | O app em um único `main.dart` (feature overload) | `flutter run -d chrome` |
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

## Esta branch (`main`)

Guarda as duas versões completas lado a lado, para consulta:

| Pasta | O que é |
|---|---|
| `rotina_bagunca/` | Tudo em um único arquivo (feature overload) |
| `rotina_limpo/` | Clean Architecture, segurança e testes |

## Senha de demonstração
Qualquer e-mail válido com a senha `123456`.
