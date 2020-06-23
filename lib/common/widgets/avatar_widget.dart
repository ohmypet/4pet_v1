part of petisland.common.widgets;

class AvatarWidget extends StatelessWidget {
  final String url;
  final EdgeInsetsGeometry paddingDefaultImage;

  const AvatarWidget({
    Key key,
    this.url,
    this.paddingDefaultImage = const EdgeInsets.all(2.0),
  }) : super(key: key);

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
    return Container(
      decoration: BoxDecoration(
        color: TColors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: paddingDefaultImage,
        child: SvgPicture.asset(TAssets.user_avatar),
      ),
    );
  }

  Widget _buildImage(ImageSources type, String url) {
    return type == ImageSources.Server
        ? TCacheImageWidget(
            url: url,
            shape: BoxShape.circle,
          )
        : Image.file(File(url));
  }
}
