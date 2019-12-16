part of petisland_core.domain;

class Post extends BaseModel implements PostItem {
  String title;
  String description;
  String location;
  double price;
  DateTime dueDate;
  String status;
  Account account;
  Pet pet;
  bool isReacted = false;

  final Map<String, dynamic> settings = <String, dynamic>{};
  final List<PostImage> postImages = <PostImage>[];
  final List<PostTag> postTags = <PostTag>[];

  int likes;

  Post({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.title,
    this.description,
    this.location,
    this.price = 0,
    this.dueDate,
    this.status,
    this.account,
    this.pet,
    this.likes,
    this.isReacted = false,
    Map<String, dynamic> settings,
    List<PostImage> postImages,
    List<PostTag> postTags,
  }) : super(id, createAt, updateAt, createBy) {
    if (settings?.isNotEmpty == true) this.settings.addAll(settings);
    if (postImages?.isNotEmpty == true) this.postImages.addAll(postImages);
    if (postTags?.isNotEmpty == true) this.postTags.addAll(postTags);
  }

  Post.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    title = json['title'];
    description = json['description'];
    location = json['location'];
    price = double.tryParse(json['price']?.toString());
    dueDate = _parseDateTime(json['dueDate']);
    if (json['settings']?.isNotEmpty == true) settings.addAll(json['settings']);
    status = json['status'];
    account = json['account'] != null ? Account.fromJson(json['account']) : null;
    pet = json['pet'] != null ? Pet.fromJson(json['pet']) : null;
    postImages.addAll(_parsePostImages(json['postImages']));
    postTags.addAll(_parsePostTags(json['postTags']));
    likes = json['likes'];
    isReacted = json['isReacted'] ?? false;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson();
    _addValueToMap('title', title, map);
    _addValueToMap('description', description, map);
    _addValueToMap('location', location, map);
    _addValueToMap('price', price, map);
    _addValueToMap('due_date', dueDate?.toIso8601String(), map);
    _addValueToMap('settings', settings, map);
    _addValueToMap('status', status, map);
    _addValueToMap('account', account?.toJson(), map);
    _addValueToMap('pet', pet?.toJson(), map);
    final List<Map<String, dynamic>> json = _postImageToJson(postImages);
    _addValueToMap('postImages', json, map);
    _addValueToMap('likes', likes, map);

    return map;
  }

  List<PostImage> _parsePostImages(List<dynamic> items) {
    if (items == null)
      return <PostImage>[];
    else {
      return items
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> json) => PostImage.fromJson(json))
          .toList();
    }
  }

  List<PostTag> _parsePostTags(List<dynamic> items) {
    if (items == null) {
      return <PostTag>[];
    } else {
      return items
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> json) => PostTag.fromJson(json))
          .toList();
    }
  }

  List<Map<String, dynamic>> _postImageToJson(List<PostImage> postImages) {
    return postImages.map((PostImage postImage) => postImage.toJson()).toList();
  }
}
