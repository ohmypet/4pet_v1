part of petisland_core.domain;

class NotificationType {
  String name;
  String id;

  NotificationType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
}

class PetNotification extends BaseModel {
  String message;
  Account sender;
  bool isRead;
  NotificationType type;

  List<TextConfig> get textConfigs => StringUtils.getTextConfigs(message) ?? [];

  PetNotification(
    String id,
    DateTime createAt,
    DateTime updateAt,
    Account createBy, {
    this.message,
    this.sender,
    this.isRead,
  }) : super(id, createAt, updateAt, createBy);

  PetNotification.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['_id'];
    message = json['message'];
    sender = json['sender'] is Map ? Account.fromJson(json['sender']) : null;
    isRead = json['isRead'] ?? false;
    type = json['category'] != null ? NotificationType.fromJson(json['category']) : null;
  }
}
