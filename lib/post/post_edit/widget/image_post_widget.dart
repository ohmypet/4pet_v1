part of petisland.post.post_edit.widget;

class ImagePostWidget extends StatelessWidget {
  ///Index in PetImage List for display Images's Post
  final int index;
  final String url;
  final void Function(int, ImageSources) onTapRemove;
  final ImageSources type;

  ImagePostWidget(this.url, {@required this.onTapRemove, this.index, Key key})
      : type =
            StringUtils.isImageUrlFormat(url) ? ImageSources.Server : ImageSources.Local,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: <Widget>[
            imageDefaultWidget(),
            PostImageWidget(imageUrl: url, fit: BoxFit.cover),
            Positioned(
              top: 2,
              right: 2,
              child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: TColors.white.withAlpha(220),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: TColors.water_melon,
                  ),
                ),
                onTap: _onTapRemoveImage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageDefaultWidget() {
    return Container(
      height: 75,
      width: 75,
      color: TColors.duck_egg_blue,
    );
  }

  void _onTapRemoveImage() {
    if (onTapRemove != null) onTapRemove(index, type);
  }
}
