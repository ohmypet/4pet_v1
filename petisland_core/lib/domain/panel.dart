part of petisland_core.domain;

class Panel extends Item {
  String type;
  List<PanelDetail<PostItem>> items;

  Panel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    final List<Map<String, dynamic>> data =
        json['data']?.cast<Map<String, dynamic>>() ?? const <Map<String, dynamic>>[];

    items = data.map((Map<String, dynamic> item) => PanelDetail<PostItem>.fromJson(item));
  }
}
