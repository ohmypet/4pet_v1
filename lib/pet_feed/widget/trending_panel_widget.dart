part of petisland.pet_feed.widget;

class TrendingPanelWidget extends PanelRender<Panel> {
  TrendingPanelWidget(Panel panel, {Key key}) : super(panel, key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: panel.items.length,
      itemBuilder: (_, int index) {
        final PanelDetail item = panel.items[index];
        return render(item);
      },
    );
  }
}
