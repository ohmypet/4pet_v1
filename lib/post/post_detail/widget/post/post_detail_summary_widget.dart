part of petisland.post.screen.widget;

class PostDetailSummaryWidget extends StatelessWidget {
  final Post item;

  const PostDetailSummaryWidget({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageSliderWidget = _buildImageSlider(item.postImages);
    return Flex(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.vertical,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: PostPreviewWidget(item: item),
              ),
              Expanded(
                flex: 1,
                child: PostButtonBar(item: item),
              )
            ],
          ),
        ),
        SizedBox(height: 15),
        buildTextDescription(context, 'Miêu tả'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: PostDescriptionWidget(description: item.description),
        ),
        Flexible(child: imageSliderWidget),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildImageSlider(List<PostImage> postImages) {
    return postImages?.isNotEmpty == true
        ? Container(
            height: 150,
            child: ImageSliderWidget(
              postImages: item.postImages,
              description: 'Ảnh thú cưng',
            ),
          )
        : SizedBox();
  }
}
