part of petisland_core.domain;

class Account extends BaseModel {
  String username;
  String email;
  String role;
  String status;
  Map<String, dynamic> settings;
  User user;

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
    this.user,
  }) : super(id, createAt, updateAt, createBy);

  Account.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    username = json['username'];
    email = json['email'];
    role = json['role'];
    status = json['status'];
    settings = json['settings'];
    user = json['user'];
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
