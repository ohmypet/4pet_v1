part of petisland.pet_feed.widget;

class PostWidget extends PostItemRender<Post> {
  PostWidget(Post item) : super(item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToScreen(context: context,screen: PostEditScreen.edit(item)),
      child: Container(
        height: 30,
        width: 15,
        color: TColors.water_melon,
      ),
    );
  }
}
