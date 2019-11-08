part of petisland_core.exception;

class PetExeption implements Exception {
  String message;
  String stackTrace;

  PetExeption([this.message, this.stackTrace]);

  PetExeption.fromException(dynamic ex)
      : message = ex.message,
        stackTrace = ex.stackTrace;

  @override
  String toString() => 'Error:: $message $stackTrace';
}
