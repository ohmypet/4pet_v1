part of petisland.pet_feed.widget.post_category.dart;

class PetCategoryWidget extends PostItemRender<PetCategory> {
  final VoidCallback onTap;

  PetCategoryWidget(PetCategory item, {Key key, this.onTap})
      : super(item, key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Stack(
        children: <Widget>[
          _CategoryImageWidget(item: item),
          _CategoryDescriptionWidget(item: item),
        ],
      ),
    );
  }

  void _onTap() {
    if (onTap != null) onTap();
  }
}
