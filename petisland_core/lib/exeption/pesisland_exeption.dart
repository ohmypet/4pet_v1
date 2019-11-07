part of petisland_core.exception;

@immutable
class PetExeption implements Exception {
  final String message;
  final String stackTrace;

  const PetExeption([this.message, this.stackTrace]);

  PetExeption.fromException(dynamic ex)
      : message = ex.message,
        stackTrace = ex.stackTrace;

  @override
  String toString() => 'Error:: $message $stackTrace';
}
