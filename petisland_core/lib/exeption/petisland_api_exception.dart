part of petisland_core.exception;

class PetApiExecption extends PetExeption {
  int statusCode;
  String error;

  PetApiExecption({this.statusCode, this.error, String message}) : super(message);

  PetApiExecption.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    message = json['message'];
  }
}
