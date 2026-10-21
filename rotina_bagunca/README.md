# rotina_bagunca

Rotina+ **com feature overload**: tudo funciona, mas está misturado em um único
arquivo (`lib/main.dart`). Este é o ponto de partida da oficina da SEMPESq 2026.
A versão corrigida é o `rotina_limpo`.

## Funcionalidades
- **Login falso:** qualquer e-mail válido e a senha `123456`.
- **Tela principal:** clima do dia (Open-Meteo) e lista de tarefas (JSONPlaceholder), com adicionar e marcar como concluída.
- **Sair:** apaga a sessão.

## Como rodar
O repositório traz só o código (`lib/`). Gere as pastas de plataforma uma vez:

```bash
flutter create . --project-name rotina_bagunca --platforms=android,ios
rm test/widget_test.dart   # teste padrão do Flutter, não se aplica aqui
flutter pub get
flutter run
```

Android: para o app de **release** acessar a internet, confira se o arquivo
`android/app/src/main/AndroidManifest.xml` tem
`<uses-permission android:name="android.permission.INTERNET"/>` antes de `<application>`.
(No modo debug isso já funciona.)

## Tarefa da oficina
Refatore a feature **Tarefas** para Clean Architecture (data, domain, presentation),
depois corrija os problemas de segurança e escreva os testes.
Use o `rotina_limpo` como gabarito.
