part of petisland_core.exception;

@immutable
class PetApiExecption extends PetExeption {
  final String reason;

  const PetApiExecption({String message, this.reason, String stackStrace}) : super(message, stackStrace);

  PetApiExecption.fromJson(Map<String, dynamic> json)
      : reason = json['reason'],
        super(json['message']);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'reason': reason,
      'stackTrace': stackTrace,
    };
  }

  @override
  String toString() => 'TApiExecption:: $message, $reason, $stackTrace';
}
