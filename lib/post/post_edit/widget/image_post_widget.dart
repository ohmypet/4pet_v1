part of petisland.post.post_edit.widget;

class ImagePostWidget extends StatelessWidget {
  ///Index in PetImage List for display Images's Post
  final int index;
  final PostImage postImage;
  final void Function(int, ImageType) onTapRemove;
  final ImageType type;

  ImagePostWidget(this.postImage, {@required this.onTapRemove, this.index, Key key})
      : type = StringUtils.isImageUrlFormat(postImage.image.url)
            ? ImageType.Server
            : ImageType.Local,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = postImage.image.url;
    Widget child = type == ImageType.Server
        ? TCacheImageWidget(borderRadius: BorderRadius.circular(0), url: imageUrl)
        : Image.file(File(imageUrl), fit: BoxFit.cover);

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 100,
            width: 100,
            child: child,
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: TColors.white.withAlpha(220),
                ),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: TColors.water_melon,
                ),
              ),
              onTap: _onTapRemoveImage,
            ),
          ),
        ],
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
