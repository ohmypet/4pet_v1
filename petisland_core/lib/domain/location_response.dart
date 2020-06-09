part of petisland_core.domain;


class LocationResponse {
  List<LocationInfo> predictions;
  String status;
  bool get success => status == 'OK';
  
  LocationResponse.fromJson(Map<String, dynamic> json) {
    final items = json['predictions'] as List ?? [];
    status = json['status'];
    predictions = items.map((e) => LocationInfo.fromJson(json)).toList();
  }
}