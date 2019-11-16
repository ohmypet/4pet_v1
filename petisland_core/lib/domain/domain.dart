library petisland_core.domain;

import 'package:meta/meta.dart';
import 'package:petisland_core/util/log.dart';

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

List<Image> _parseImages(List<Map<String, dynamic>> images) {
  images ??= <Map<String, dynamic>>[];
  return images
      .map((Map<String, dynamic> item) => Image.fromJson(item))
      .toList();
}

DateTime _parseDateTime(String time) {
  try {
    if (time is String)
      return DateTime.parse(time);
    else
      return null;
  } catch (ex) {
    Log.debug(ex);
    return null;
  }
}

List<Tag> _parseTags(List<Map<String, dynamic>> tags) {
  tags ??= <Map<String, dynamic>>[];
  return tags.map((Map<String, dynamic> item) => Tag.fromJson(item)).toList();
}
