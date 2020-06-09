part of petisland_core.domain;

class LocationInfo {
  String id;
  String description;
  String placeId;
  String reference;
  List matchedSubstrings;
  Map structuredFormatting;
  List terms;
  List types;

  LocationInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    placeId = json['place_id'];
    reference = json['reference'];
    matchedSubstrings = json['matched_substrings'];
    structuredFormatting = json['structured_formatting'];
    terms = json['terms'];
    types = json['types'];
  }
}