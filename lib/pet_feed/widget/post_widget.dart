part of petisland.pet_feed.widget;

class PostWidget extends PostItemRender<Post> {
  PostWidget(Post item) : super(item);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      color: TColors.black,
    );
  }
}
