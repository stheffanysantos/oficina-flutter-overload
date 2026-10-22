/// Configuração vinda de fora do código.
/// Uso: flutter run --dart-define=API_KEY=minha_chave
abstract final class Env {
  static const apiKey = String.fromEnvironment('API_KEY');
}
