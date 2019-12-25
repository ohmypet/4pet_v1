part of petisland_core.domain;

class NotificationType {
  String name;
  String id;

  NotificationType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
}

class Notification extends BaseModel {
  String message;
  Account sender;
  bool isReaded;
  NotificationType type;

  Notification(
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy, {
    this.message,
  }) : super(id, createAt, updateAt, createBy);

  Notification.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['_id'];
    message = json['message'];
    sender = json['sender'] != null ? Account.fromJson(json['sender']) : null;
    isReaded = json['isReaded'] ?? false;
    type = json['category'] != null ? NotificationType.fromJson(json['category']) : null;
  }
}
