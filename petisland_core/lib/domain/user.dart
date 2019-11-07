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

  @override
  Map<String, dynamic> toJson() {
    // super.
    final Map<String, dynamic> map = super.toJson();
    _addValueToMap('name', name, map);
    _addValueToMap('phone_numbder', phoneNumber, map);
    _addValueToMap('address', address, map);
    _addValueToMap('bio', bio, map);
    _addValueToMap('dob', dob, map);
    _addValueToMap('settings', settings, map);
    _addValueToMap('account', account?.toJson(), map);
    _addValueToMap('avatar', avatar?.toJson(), map);
    return map;
  }
}
