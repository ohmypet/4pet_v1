part of petisland_core.exception;

class PetApiException extends PetException {
  static const int no_auth = 401;
  static const int code_time_out = 408;

  int statusCode;
  String error;

  PetApiException({this.statusCode, this.error, String message})
      : super(message);

  PetApiException.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    message = json['message'];
  }

  @override
  String toString() => super.toString() + ' status: $statusCode';
}

class LimitRetryException extends PetApiException {
  LimitRetryException() : super(message: 'Limit retry upload');
}
