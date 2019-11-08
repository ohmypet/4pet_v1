part of petisland_core.exception;

class PetApiException extends PetException {
  int statusCode;
  String error;

  PetApiException({this.statusCode, this.error, String message}) : super(message);

  PetApiException.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    message = json['message'];
  }
}
