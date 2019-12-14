part of petisland.pet_feed.widget;

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
          // final PanelDetail item = panel.items[index];
          // return renderPostDetail(item);
          return AspectRatio(
            aspectRatio: 3 / 4,
            child: Container(
              color: TColors.water_melon,
            ),
          );
        },
        separatorBuilder: (_, int index) => SizedBox(width: 2),
      ),
    );
  }
}
