part of petisland.pet_feed.widget.trending_panel;

class TrendingPanelWidget extends PanelRender<Panel> {
  TrendingPanelWidget(Panel panel, {Key key}) : super(panel, key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ListView.separated(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemCount: panel.items.length,
        itemBuilder: (_, int index) {
          final PanelDetail item = panel.items[index];
          if (item.postItem is Post) {
            final Widget child = _PostTrendingWidget(item.postItem);
            return AspectRatio(
              aspectRatio: 3 / 4,
              child: Container(
                color: TColors.darkSkyBlue,
                child: child,
              ),
            );
          } else {
            Log.warn(
                'TrendingPanelWidget::build dont support ${item.postItem.runtimeType}');
            return SizedBox();
          }
          // if (item.)
        },
        separatorBuilder: (_, int index) => SizedBox(width: 2),
      ),
    );
  }
}

class _PostTrendingWidget extends StatelessWidget {
  final Post item;
  _PostTrendingWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: TColors.water_melon,
      ),
      child: Stack(
        children: <Widget>[PostImageWidget(item: item)],
      ),
    );
  }
}
