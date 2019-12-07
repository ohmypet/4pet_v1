part of petisland_core.domain;

class Panel extends Item {
  String type;
  List<PanelDetail> items;

  Panel.fromJson(Map<String, dynamic> json) {
    type = json['type'];

    final List<Map<String, dynamic>> data =
        json['data']?.cast<Map<String, dynamic>>() ?? const <Map<String, dynamic>>[];

    items = data
        .map((Map<String, dynamic> item) => PanelDetail.fromJson(item))
        .where((PanelDetail item) => item.type != null && item.postItem != null)
        .toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    _addValueToMap('type', type, map);
    final List<Map<String, dynamic>> dataToJson = items.map((PanelDetail item) => item.toJson()).toList();
    _addValueToMap('data', dataToJson, map);
    return map;
  }
}
