/// Erro de negócio com mensagem pronta para o usuário.
class Failure implements Exception {
  const Failure(this.message);

  final String message;

  @override
  String toString() => message;
}
