class FaunaDbException implements Exception {
  final String cause;
  FaunaDbException(this.cause);
}