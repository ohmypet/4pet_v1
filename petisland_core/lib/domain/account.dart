part of petisland_core.domain;

class Account extends BaseModel {
  String username;
  String email;
  String role;
  String status;
  Map<String, dynamic> settings;

  Account({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.username,
    this.email,
    this.role,
    this.status,
    this.settings,
  }) : super(id, createAt, updateAt, createBy);

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(createAt: json['']);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson();
    _addValueToMap('username', username, map);
    _addValueToMap('email', email, map);
    _addValueToMap('role', role, map);
    _addValueToMap('status', status, map);
    _addValueToMap('settings', settings, map);
    return map;
  }
}
