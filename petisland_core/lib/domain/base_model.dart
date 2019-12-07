part of petisland_core.domain;

abstract class BaseModel {
  String id;
  DateTime createAt;
  DateTime updateAt;
  Account createBy;

  BaseModel(this.id, this.createAt, this.updateAt, this.createBy);

  @mustCallSuper
  BaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createAt = _parseDateTime(json['create_at']);
    updateAt = _parseDateTime(json['update_at']);
    createBy = json['create_by'] != null ? Account.fromJson(json['create_by']) : null;
  }

  @mustCallSuper
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    _addValueToMap('id', id, map);
    _addValueToMap('create_at', createAt?.toIso8601String(), map);
    _addValueToMap('update_at', updateAt?.toIso8601String(), map);
    _addValueToMap('create_by', createBy?.toJson(), map);
    return map;
  }
}
