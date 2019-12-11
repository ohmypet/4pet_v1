part of petisland.pet_feed.widget;

abstract class PostItemRender<T extends PostItem> extends TStatelessWidget {
  final T item;

  const PostItemRender(this.item, {Key key}) : super(key: key);
}
