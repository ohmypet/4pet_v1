library petisland_core.domain;

import 'package:meta/meta.dart';

part 'account.dart';
part 'base_model.dart';
part 'comment.dart';
part 'image.dart';
part 'login_data.dart';
part 'pet.dart';
part 'post.dart';
part 'review.dart';
part 'tag.dart';
part 'user.dart';

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
