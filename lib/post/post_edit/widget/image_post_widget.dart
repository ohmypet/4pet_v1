part of petisland.post.post_edit.widget;

class ImagePostWidget extends StatelessWidget {
  ///Index in PetImage List for display Images's Post
  final int index;
  final String url;
  final void Function(int, ImageType) onTapRemove;
  final ImageType type;

  ImagePostWidget(this.url,
      {@required this.onTapRemove, this.index, Key key})
      : type = StringUtils.isImageUrlFormat(url)
            ? ImageType.Server
            : ImageType.Local,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = type == ImageType.Server
        ? TCacheImageWidget(borderRadius: BorderRadius.circular(0), url: url)
        : Image.file(File(url), fit: BoxFit.cover);

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: <Widget>[
            child,
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
      height: 100,
      width: 100,
      color: TColors.duck_egg_blue,
    );
  }

  void _onTapRemoveImage() {
    if (onTapRemove != null) onTapRemove(index, type);
  }
}
