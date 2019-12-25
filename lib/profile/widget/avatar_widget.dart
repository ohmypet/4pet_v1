part of petisland.profile.widget;

class AvatarWidget extends StatelessWidget {
  final String url;
  final VoidCallback onTapCamera;

  const AvatarWidget({Key key, this.url, this.onTapCamera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (url != null) {
      final type = StringUtils.isImageUrlFormat(url) ? ImageType.Server : ImageType.Local;
      child = _buildImage(type, url);
    } else {
      child = buildDefaultAvatar();
    }
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: TGradients.avatarGradient2,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 150,
                width: 150,
                child: FittedBox(
                  child: child,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          _buildIconCamera()
        ],
      ),
    );
  }

  Widget _buildImage(ImageType type, String url) {
    return type == ImageType.Server
        ? TCacheImageWidget(
            url: url,
            height: 10,
            shape: BoxShape.circle,
            width: 10,
          )
        : Image.file(File(url));
  }

  Widget buildDefaultAvatar() {
    return SvgPicture.asset(TAssets.user_avatar);
  }

  Widget _buildIconCamera() {
    return Container(
      height: 150,
      width: 150,
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: _onTapCamera,
        child: Container(
          decoration: BoxDecoration(
            color: TColors.duck_egg_blue,
            shape: BoxShape.circle,
            border: Border.all(
              color: TColors.white,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(Icons.camera_alt),
          ),
        ),
      ),
    );
  }

  void _onTapCamera() {
    if (onTapCamera != null) onTapCamera();
  }
}
