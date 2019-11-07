part of petisland_core.domain;

abstract class BaseModel {
  String id;
  DateTime createAt;
  DateTime updateAt;
  Account createBy;

  @mustCallSuper
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    _addValueToMap('id', id, map);
    _addValueToMap('create_at', createAt, map);
    _addValueToMap('update_at', updateAt, map);
    _addValueToMap('create_by', createBy?.toJson(), map);
    return map;
  }
}
