part of petisland_core.domain;

class User with BaseModel {
  String name;
  String phoneNumber;
  Map<String, dynamic> address;
  String bio; //
  DateTime dob; // day of birth
  Map<String, dynamic> settings;
  Account account;
  Image avatar;

  User({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.account,
    this.address,
    this.avatar,
    this.phoneNumber,
    this.bio,
    this.dob,
    this.name,
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
    _addValueToMap('name', name, map);
    _addValueToMap('phone_numbder', phoneNumber, map);
    _addValueToMap('address', address, map);
    _addValueToMap('bio', bio, map);
    _addValueToMap('dob', dob?.toIso8601String(), map);
    _addValueToMap('settings', settings, map);
    _addValueToMap('account', account?.toJson(), map);
    _addValueToMap('avatar', avatar?.toJson(), map);
    return map;
  }
}
