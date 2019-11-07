library petisland_core.domain;

import 'package:meta/meta.dart';

part 'account.dart';
part 'user.dart';
part 'base_model.dart';
part 'image.dart';
part 'post.dart';
part 'pet.dart';
part 'review.dart';
part 'comment.dart';
part 'tag.dart';

void _addValueToMap(String key, dynamic value, Map<String, dynamic> map) {
  if (value != null) map[key] = value;
}

List<Map<String, dynamic>> _imagesToJson(List<Image> images) {
  if (images != null) {
    return images.map((Image item) => item.toJson()).toList();
  } else {
    return null;
  }
}
