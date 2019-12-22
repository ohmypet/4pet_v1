part of pestisland.post.post_edit.bloc;

abstract class PostEditState extends BaseState {
  @override
  String toString() => '$runtimeType';
}

class InitState extends PostEditState {
  final String title = '';
  final double price = 0;

  @override
  String toString() => 'InitState';
}

class TitleState extends PostEditState {
  final String title;

  TitleState(this.title);

  @override
  String toString() => 'TitleState:: title: $title';
}

class PriceState extends PostEditState {
  final double price;

  PriceState(this.price);

  @override
  String toString() => 'PriceState:: price: $price';
}

class ImageState extends PostEditState {
  final List<PostImage> imagesLocalPath;

  ImageState(this.imagesLocalPath);
}

class ExpandState extends PostEditState {
  @override
  String toString() => 'ExpandState';
}
