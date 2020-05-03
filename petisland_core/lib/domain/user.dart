part of petisland_core.domain;

class User extends BaseModel {
  String name;
  String phoneNumber;
  dynamic address;
  String bio; //
  DateTime dob; // day of birth
  Map<String, dynamic> settings;
  Account account;
  PetImage avatar;

  User({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    @required this.phoneNumber,
    @required this.name,
    this.account,
    this.address,
    this.avatar,
    this.bio,
    this.dob,
    this.settings,
  }) : super(id, createAt, updateAt, createBy);

  User.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    address = json['address'];
    avatar = json['avatar'] != null ? PetImage.fromJson(json['avatar']) : null;
    phoneNumber = json['phoneNumber'];
    bio = json['bio'];
    dob = _parseDateTime(json['dob']);
    name = json['name'];
    settings = json['settings'];
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

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> map = {};
    _addValueToMap('name', name, map);
    _addValueToMap('phoneNumber', phoneNumber, map);
    _addValueToMap('address', address, map);
    _addValueToMap('bio', bio, map);
    _addValueToMap('dob', dob?.toIso8601String(), map);
    _addValueToMap('settings', settings, map);
    _addValueToMap('avatar', avatar?.toJson(), map);
    return map;
  }
}
