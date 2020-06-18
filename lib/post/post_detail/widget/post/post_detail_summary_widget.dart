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
                child: PreviewPostWidget(item: item),
              ),
              Expanded(
                flex: 1,
                child: PostButtonBar(item: item),
              )
            ],
          ),
        ),
        ...(item.description.isNotEmpty
            ? _buildDescriptions(description: item.description, context: context)
            : [SizedBox()]),
        Flexible(child: imageSliderWidget),
        SizedBox(height: 5),
      ],
    );
  }

  Widget _buildImageSlider(List<PostImage> postImages) {
    return postImages?.isNotEmpty == true
        ? Container(
            height: 150,
            child: ImageSliderWidget(
              images: item.postImages.map((e) => e.image.url).toSet().toList(),
              description: 'Images',
            ),
          )
        : SizedBox();
  }

  List<Widget> _buildDescriptions({@required BuildContext context, String description}) {
    return [
      const SizedBox(height: 15),
      buildTextDescription(context, 'Description'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: PostDescriptionWidget(description: description),
      ),
    ];
  }
}
