part of petisland.pet_feed.widget.post_panel;

class PostPanelDetailWidget extends PanelRender<Panel> {
  final VoidCallback reRender;
  PostPanelDetailWidget(
    Panel panel, {
    Key key,
    this.reRender,
  }) : super(panel, key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: PanelDescriptionBar(
            title: PetIslandConstants.getCategoryStringFromType(panel.type),
            onTapSubTitle: () => _onTapSeeMore(context),
            // TODO(tvc12): Disable see more feature, open in next version
            enableSubtitle: false,
          ),
        ),
        const SizedBox(height: 5),
        Flexible(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: panel.items.length,
              separatorBuilder: (_, int index) => SizedBox(width: 10),
              itemBuilder: _buildItem,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    Widget child;
    final PanelDetail item = panel.items[index];
    switch (item.postItem.runtimeType) {
      case Post:
        child = _PostWidget(
          item.postItem,
          onTap: () => _onTapPostItem(context, item.postItem),
        );
        break;
      case PetCategory:
        child = PetCategoryWidget(
          item.postItem,
          onTap: () => _onTapPetCategory(context, item),
        );
        break;
      default:
        Log.warn('_buildItem::build dont support ${item.postItem.runtimeType}');
        child = SizedBox();
    }

    return AspectRatio(
      aspectRatio: 3 / 4,
      child: child,
    );
  }

  void _onTapPetCategory(BuildContext context, PanelDetail item) {
    Log.info('_onTapPetCategory:: $item');
    // TODO(tvc12): navigate to search
  }

  void _onTapPostItem(BuildContext context, Post item) {
    navigateToScreen(
      context: context,
      screen: PostDetailScreen(
        item: item,
        onDeletePost: () => _removePost(item.id),
      ),
      screenName: PostDetailScreen.name,
    ).whenComplete(() {
      if (reRender != null) {
        reRender();
      }
    });
  }

  void _onTapSeeMore(BuildContext context) {
    // TODO(tvc12): navigate to search
  }

  void _removePost(String id) {
    DI.get<PetFeedController>(PetFeedController).remove(id);
  }
}
