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
            _TitleWidget(title: 'Images'),
            const SizedBox(height: 5),
            BlocBuilder<PostEditBloc, PostEditState>(
              bloc: widget.bloc,
              builder: (_, PostEditState state) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _buildImageWidget(widget.bloc.postImages),
                  ),
                );
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

  List<Widget> _buildImageWidget(List<PostImage> postImages) {
    List<Widget> result = <Widget>[
      AddImagePostWidget(onPress: () => chooseImage())
    ];

    if (postImages == null || postImages.isEmpty) {
      return result;
    } else {
      if (canAddImage(postImages.length)) {
        result.add(SizedBox(width: 7));
      } else
        result.removeLast();
      postImages.fold(0, (i, postImage) {
        result
          ..add(ImagePostWidget(postImage, index: i, onTapRemove: _removeImage))
          ..add(SizedBox(width: 7));
        return i + 1;
      });
      return result..removeLast();
    }
  }

  void chooseImage() {
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
    if (imagesPath != null) {
      widget.bloc.addImage(imagesPath);
    }
  }

  void _removeImage(int index, ImageType type) {
    widget.bloc.removeImage(index, type);
  }
}
