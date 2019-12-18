part of petisland.post.post_edit.widget;

class ImagePostWidget extends StatelessWidget {
  ///Index in PetImage List for display Images's Post
  final int index;
  final String imageUrl;
  final void Function(int, String) onPressDelete;

  ImagePostWidget(this.imageUrl,
      {@required this.onPressDelete, this.index, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return imageDefaultWidget();
    } else {
      Widget child;
      if (isImageUrlFormat(imageUrl)) {
        child = TCacheImageWidget(
          borderRadius: BorderRadius.circular(0),
          url: imageUrl,
        );
      } else {
        child = Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        );
      }
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
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: TColors.white),
                  child: Icon(
                    Icons.close,
                    size: 20,
                  ),
                ),
                onTap: onPressDelete != null
                    ? () => onPressDelete(index, imageUrl)
                    : null,
              ),
            ),
          ],
        ),
      );
    }
  }

  bool isImageUrlFormat(String url) {
    return url.contains(RegExp('^https?://')) ||
        url.contains(RegExp('^http?://'));
  }

  Widget imageDefaultWidget() {
    return Container(
      height: 100,
      width: 100,
      color: TColors.duck_egg_blue,
    );
  }
}
