part of petisland_core.domain;

class LocationInfo {
  String id;
  String description;
  dynamic components;

  LocationInfo.fromJson(Map<String, dynamic> json) {
    if (json['annotations'] != null) id = json['annotations']['geohash'];
    components = json['components'];
    description = json['formatted'];
  }
}
