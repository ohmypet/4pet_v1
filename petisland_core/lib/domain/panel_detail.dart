part of petisland_core.domain;

abstract class Item {
  Map<String, dynamic> toJson();
}

abstract class PostItem extends Item {
  String get key;
}

class PanelDetail extends Item {
  String type;
  PostItem postItem;
  CategoryTypeEnum get categoryTypeEnum =>
      PetIslandConstants.getCategoryType(type);

  PanelDetail.post(this.postItem) : type = 'Post';
  PanelDetail.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    final Map<String, dynamic> data = json['data'] ?? <String, dynamic>{};
    if (type == 'Post') {
      final PostItem post = Post.fromJson(data);
      postItem = post;
    } else {
      final PostItem post = PetCategory.fromJson(data);
      postItem = post;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    _addValueToMap('type', type, map);
    _addValueToMap('data', postItem.toJson(), map);
    return map;
  }
}
