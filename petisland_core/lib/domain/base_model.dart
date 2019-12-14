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
    createAt = _parseDateTime(json['createdAt']);
    updateAt = _parseDateTime(json['updatedAt']);
    createBy = json['createdBy'] != null ? Account.fromJson(json['createdBy']) : null;
  }

  @mustCallSuper
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    _addValueToMap('id', id, map);
    _addValueToMap('createdAt', createAt?.toIso8601String(), map);
    _addValueToMap('updatedAt', updateAt?.toIso8601String(), map);
    _addValueToMap('createdBy', createBy?.toJson(), map);
    return map;
  }
}
