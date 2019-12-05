part of petisland_core.domain;

abstract class Item {}

abstract class PostItem {}

class PanelDetail<T extends PostItem> extends Item {
  String type;
  T postItem;

  PanelDetail.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    final Map<String, dynamic> data = json['data'] ?? <String, dynamic>{};

    if (type == 'Post') {
      final PostItem post = Post.fromJson(data);
      postItem = post;
    } else if (type == 'Pet category') {
      final PostItem post = PetCategory.fromJson(data);
      postItem = post;
    }
  }
}
