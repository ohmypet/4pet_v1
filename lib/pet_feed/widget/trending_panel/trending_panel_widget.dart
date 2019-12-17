part of petisland.pet_feed.widget.trending_panel;

class TrendingPanelWidget extends PanelRender<Panel> {
  TrendingPanelWidget(Panel panel, {Key key}) : super(panel, key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: _TrendingDescriptionBar(
            panel: panel,
            onTap: () => _onTapSeeMore(context),
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
    final PanelDetail item = panel.items[index];
    if (item.postItem is Post) {
      return AspectRatio(
        aspectRatio: 3 / 4,
        child: _PostTrendingWidget(
          item.postItem,
          onTap: () => _onTap(context, item.postItem),
        ),
      );
    } else {
      Log.warn('TrendingPanelWidget::build dont support ${item.postItem.runtimeType}');
      return SizedBox();
    }
  }

  void _onTap(BuildContext context, Post item) {
    // TODO(tvc12): navigate to post detail
    navigateToScreen(
      context: context,
      screen: PostEditScreen.edit(item),
    );
  }

  void _onTapSeeMore(BuildContext context) {
    // TODO(tvc12): navigate to search

  }
}
