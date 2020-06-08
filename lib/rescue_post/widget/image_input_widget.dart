part of petisland.rescue_post.widget;

class ImageInputWidget extends TStatelessWidget {
  final List<String> images;
  final String title;
  final bool isRequired;
  final ValueChanged<String> onAddImage;
  final void Function(int, ImageType) onTapRemove;

  ImageInputWidget({
    Key key,
    this.title = 'Images',
    this.isRequired = false,
    this.images = const <String>[],
    this.onAddImage,
    this.onTapRemove,
  }) : super(key: key);

  final int maxImage = Config.getMaxImages();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5, left: 13),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TitleWidget(
            title: title,
            isRequired: isRequired,
          ),
          const SizedBox(height: 5),
          SizedBox(
            child: _buildImageSlider(context),
            height: 85,
          ),
        ],
      ),
    );
  }

  bool canAddImage(int imagePostLength) {
    imagePostLength ??= 0;
    return imagePostLength < maxImage;
  }

  void chooseImage(BuildContext context) {
    showModalBottomSheet<File>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => ImageChoosePopup(),
    ).then((File file) {
      if (file != null) {
        addImage(file.absolute.path);
        return null;
      } else {
        return retrieveLostData();
      }
    }).then((File file) {
      if (file != null) addImage(file.absolute.path);
    }).catchError((ex) => Log.error('chooseImage:: $ex'));
  }

  void addImage(String imagesPath) {
    if (onAddImage != null) {
      onAddImage(imagesPath);
    }
  }

  void _removeImage(int index, ImageType type) {
    if (onTapRemove != null) {
      onTapRemove(index, type);
    }
  }

  Widget _buildImageSlider(BuildContext context) {
    final images = this.images ?? [];
    if (images.isEmpty) {
      return AddImagePostWidget(onPress: () => chooseImage(context));
    } else if (canAddImage(images.length)) {
      return Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        children: [
          AddImagePostWidget(onPress: () => chooseImage(context)),
          const SizedBox(width: 5),
          Expanded(child: _buildSliderImage(images)),
        ],
      );
    } else {
      return _buildSliderImage(images);
    }
  }

  Widget _buildSliderImage(List<String> images) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (_, index) => ImagePostWidget(images[index], index: index, onTapRemove: _removeImage),
      separatorBuilder: (_, index) => const SizedBox(width: 10),
    );
  }
}
