part of petisland_core.domain;

class Account with BaseModel {
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
  }) {
    this.id = id;
    this.createAt = createAt;
    this.createBy = createBy;
    this.updateAt = updateAt;
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
