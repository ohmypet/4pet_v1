part of petisland.post.post_edit.widget;

class ImagePostInput extends StatefulWidget {
  final PostEditBloc bloc;
  final List<String> image;

  const ImagePostInput(
    this.bloc, {
    Key key,
    this.image = const <String>[],
  }) : super(key: key);

  @override
  _ImagePostInputState createState() => _ImagePostInputState();
}

class _ImagePostInputState extends State<ImagePostInput> {
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildImageWidget(widget.image),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                canAddImage(widget.image?.length)
                    ? InkWell(
                        onTap: () {},
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

  List<Widget> _buildImageWidget(List<String> imageUrl) {
    Widget imageDefaultWidget() {
      return Container(
        height: 55,
        width: 55,
        color: TColors.duck_egg_blue,
      );
    }

    Widget imageWidget(String url,
        {@required Function(String url) onPressDelete}) {
      Widget result;
      if (url != null && url.isNotEmpty) {
        result = Stack(
          children: <Widget>[
            TCacheImageWidget(
              url: url,
              height: 100,
              width: 100,
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                child: Icon(
                  Icons.close,
                  size: 20,
                ),
                onTap: onPressDelete != null ? onPressDelete(url) : null,
              ),
            ),
          ],
        );
      } else {
        result = imageDefaultWidget();
      }
      return result;
    }

    if (imageUrl == null || imageUrl.isEmpty) {
      return <Widget>[imageDefaultWidget()];
    } else {
      List<Widget> result = [];
      imageUrl.forEach((String url) {
        result
          ..add(imageWidget(url))
          ..add(SizedBox(
            width: 7,
          ));
      });
      return result..removeLast();
    }
  }
}
