part of petisland.common.widgets;

class PreviewImage extends StatelessWidget {
  static const String name = '/_PreviewImage';

  final ImageProvider imageProvider;
  final Object heroTag;
  final bool usePhotoView;

  PreviewImage(this.imageProvider, this.heroTag, {Key key, this.usePhotoView = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget background = _backgroundGradient();
    final Widget image = _imageWidget();
    final Widget appbar = _appbar(context);
    return Scaffold(
      backgroundColor: TColors.transparent,
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          image,
          background,
          appbar,
        ],
      ),
    );
  }

  Widget _backgroundGradient() {
    return Container(
      height: kToolbarHeight + 30,
      foregroundDecoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0.07),
          end: Alignment(0.5, 3),
          colors: [const Color(0x00000000), const Color(0x4d000000)],
        ),
      ),
    );
  }

  void _onClosePressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  Widget _imageWidget() {
    if (usePhotoView) {
      return Container(
        child: PhotoView(
          heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
          filterQuality: FilterQuality.high,
          imageProvider: imageProvider,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
          initialScale: PhotoViewComputedScale.contained * 1.1,
        ),
      );
    } else {
      return Hero(
        tag: heroTag,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }
  }

  Widget _appbar(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight + 30,
      child: AppBar(
        backgroundColor: TColors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          color: TColors.white,
          onPressed: () => _onClosePressed(context),
          icon: Icon(
            Icons.close,
            size: 30,
            color: TColors.white,
          ),
        ),
      ),
    );
  }
}
