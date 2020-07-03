library petisland_core.domain;

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:petisland_core/petisland_core.dart';
import 'package:petisland_core/utils/utils.dart';

part 'account.dart';
part 'base_model.dart';
part 'coin.dart';
part 'coin_history.dart';
part 'comment.dart';
part 'hero_voting_info.dart';
part 'image.dart';
part 'location_info.dart';
part 'location_response.dart';
part 'login_data.dart';
part 'notification.dart';
part 'panel.dart';
part 'panel_detail.dart';
part 'pet.dart';
part 'pet_category.dart';
part 'post.dart';
part 'post_create_modal.dart';
part 'post_edit_modal.dart';
part 'post_image.dart';
part 'post_tag.dart';
part 'recuse.dart';
part 'report.dart';
part 'rescue_account.dart';
part 'rescue_donate.dart';
part 'rescue_image.dart';
part 'rescue_voting.dart';
part 'review.dart';
part 'tag.dart';
part 'user.dart';

List<PetImage> parseImages(List<Map<String, dynamic>> images) {
  images ??= <Map<String, dynamic>>[];
  return images.map((Map<String, dynamic> item) => PetImage.fromJson(item)).toList();
}

void _addValueToMap(String key, dynamic value, Map<String, dynamic> map) {
  if (value != null) map[key] = value;
}

List<Map<String, dynamic>> _imagesToJson(List<PetImage> images) {
  if (images != null) {
    return images.map((PetImage item) => item.toJson()).toList();
  } else {
    return null;
  }
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

List<Map<String, dynamic>> _tagsToJson(List<Tag> tags) {
  if (tags != null) {
    return tags.map((Tag item) => item.toJson()).toList();
  } else {
    return null;
  }
}
