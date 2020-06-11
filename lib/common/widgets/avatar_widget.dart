part of petisland.common.widgets;

class AvatarWidget extends StatelessWidget {
  final String url;

  const AvatarWidget({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (url != null) {
      final type = StringUtils.isImageUrlFormat(url)
          ? ImageSources.Server
          : ImageSources.Local;
      child = _buildImage(type, url);
    } else {
      child = buildDefaultAvatar();
    }
    return child;
  }

  Widget buildDefaultAvatar() {
    return SvgPicture.asset(TAssets.user_avatar);
  }

  Widget _buildImage(ImageSources type, String url) {
    return type == ImageSources.Server
        ? TCacheImageWidget(
            url: url,
            height: 10,
            shape: BoxShape.circle,
            width: 10,
          )
        : Image.file(File(url));
  }
}
