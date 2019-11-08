part of petisland_core.domain;

class Pet extends BaseModel {
  String type;
  Map<String, dynamic> info;

  Pet({
    this.type,
    this.info = const <String, dynamic>{},
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
  }) : super(id, createAt, updateAt, createBy);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson();
    _addValueToMap('type', type, map);
    _addValueToMap('info', info, map);
    return map;
  }
}
