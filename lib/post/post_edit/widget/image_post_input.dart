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
                  return widget.bloc.imagesLocalPath!=null && widget.bloc.imagesLocalPath.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                _buildImageWidget(widget.bloc.imagesLocalPath),
                          ),
                        )
                      : SizedBox(height: 100,);
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                canAddImage(widget.image?.length)
                    ? InkWell(
                        onTap: () async {
                          String imageLocalPath =
                              await showModalBottomSheet<String>(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (_) => ImageChoosePopup());
                          addImage(imageLocalPath);
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 26,
                        ),
                      )
                    : SizedBox(),
              ],
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

  List<Widget> _buildImageWidget(List<String> imagePath) {
    Widget imageDefaultWidget() {
      return Container(
        height: 100,
        width: 100,
        color: TColors.duck_egg_blue,
      );
    }

    Widget imageWidget(int index, String url,
        {@required Function(int index, String url) onPressDelete}) {
      Widget result;
      if (url != null && url.isNotEmpty) {
        result = Container(
          height: 100,
          width: 100,
          child: Stack(
            children: <Widget>[
              Image.asset(url),
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  child: Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onTap: onPressDelete != null
                      ? () => onPressDelete(index, url)
                      : null,
                ),
              ),
            ],
          ),
        );
      } else {
        result = imageDefaultWidget();
      }
      return result;
    }

    if (imagePath == null || imagePath.isEmpty) {
      return <Widget>[];
    } else {
      List<Widget> result = <Widget>[];
      for (int index = 0; index < imagePath.length; ++index) {
        result
          ..add(
            imageWidget(
              index,
              imagePath[index],
              onPressDelete: removeImage,
            ),
          )
          ..add(SizedBox(
            width: 7,
          ));
      }
      return result..removeLast();
    }
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
