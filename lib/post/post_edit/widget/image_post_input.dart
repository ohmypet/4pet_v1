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
            Text(
              'Hình ảnh liên quan',
              style: TTextStyles.bold(
                fontSize: 18,
              ).copyWith(
                fontFamily: FontFamilies.thabit,
              ),
            ),
            BlocBuilder<PostEditBloc, PostEditState>(
                bloc: widget.bloc,
                builder: (_, PostEditState state) {
                  return widget.bloc.imagesLocalPath != null
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                _buildImageWidget(widget.bloc.imagesLocalPath),
                          ),
                        )
                      : SizedBox(
                          height: 100,
                        );
                }),
          ],
        ),
      ),
    );
  }

  bool canAddImage(int imagePostLength) {
    imagePostLength ??= 0;
    return imagePostLength < maxImage;
  }

  List<Widget> _buildImageWidget(List<String> imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return <Widget>[
        AddImagePostWidget(
          onPress: () => chooseImage(),
        )
      ];
    } else {
      List<Widget> result = <Widget>[];
      if (canAddImage(imagePath.length)) {
        result
          ..add(AddImagePostWidget(
            onPress: () => chooseImage(),
          ))
          ..add(SizedBox(
            width: 7,
          ));
      }
      for (int index = 0; index < imagePath.length; ++index) {
        result
          ..add(ImagePostWidget(
            imagePath[index],
            index: index,
            onPressDelete: removeImage,
          ))
          ..add(SizedBox(
            width: 7,
          ));
      }
      return result..removeLast();
    }
  }

  void chooseImage() async {
    String imageLocalPath = await showModalBottomSheet<String>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) => ImageChoosePopup());
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
