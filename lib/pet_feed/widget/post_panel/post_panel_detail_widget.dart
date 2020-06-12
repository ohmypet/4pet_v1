part of petisland.pet_feed.widget.post_panel;

class _PostTrendingWidget extends StatelessWidget {
  final Post item;
  final VoidCallback onTap;

  _PostTrendingWidget(this.item, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          PostImageWidget(imageUrl: item.firstImage, isSquare: false),
          _PostPanelDescriptionWidget(item: item)
        ],
      ),
    );
  }
}
