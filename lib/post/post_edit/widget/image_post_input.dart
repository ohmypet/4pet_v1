part of petisland.post.post_edit.widget;

class ImagePostInput extends TStatefulWidget {
  final PostEditBloc bloc;
  final List<PetImage> image;

  const ImagePostInput(
    this.bloc, {
    Key key,
    this.image = const <PetImage>[],
  }) : super(key: key);

  @override
  _ImagePostInputState createState() => _ImagePostInputState();
}

class _ImagePostInputState extends TState<ImagePostInput> {
  final int maxImage = Config.getInt('max_image_per_post');

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(right: 5, left: 13),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _TitleWidget(title: 'Hình ảnh liên quan'),
            const SizedBox(height: 5),
            BlocBuilder<PostEditBloc, PostEditState>(
              bloc: widget.bloc,
              builder: (_, PostEditState state) {
                return widget.bloc.imagesLocalPath != null
                    ? SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _buildImageWidget(widget.bloc.imagesLocalPath),
                        ),
                      )
                    : const SizedBox(height: 100);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool canAddImage(int imagePostLength) {
    imagePostLength ??= 0;
    return imagePostLength < maxImage;
  }

  List<Widget> _buildImageWidget(List<String> imagePaths) {
    List<Widget> result = <Widget>[AddImagePostWidget(onPress: () => chooseImage())];

    if (imagePaths == null || imagePaths.isEmpty) {
      return result;
    } else {
      if (canAddImage(imagePaths.length)) {
        result.add(SizedBox(width: 7));
      } else
        result.removeLast();
      imagePaths.fold(0, (i, path) {
        result
          ..add(ImagePostWidget(
            path,
            index: i,
            onPressDelete: removeImage,
          ))
          ..add(SizedBox(width: 7));
        return i + 1;
      });
      return result..removeLast();
    }
  }

  void chooseImage() async {
    String imageLocalPath = await showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => ImageChoosePopup(),
    );
    addImage(imageLocalPath);
  }

  void addImage(String imagesPath) {
    if (imagesPath != null) {
      widget.bloc.addImage(imagesPath);
    }
  }

  void removeImage(int index, String imagePath) {
    if (index != null) {
      widget.bloc.removeImage(index, imagePath);
    }
  }
}
