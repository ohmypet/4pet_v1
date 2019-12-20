part of petisland.post.post_detail.screen;

class PostDetailScreen extends StatelessWidget {
  static const name = '/PostDetailScreen';
  final Post item;

  const PostDetailScreen({Key key, @required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final imageSliderWidget = item.postImages?.isNotEmpty == true
        ? ImageSliderWidget(
            postImages: item.postImages,
            description: 'Ảnh thú cưng',
          )
        : SizedBox();
    return Scaffold(
      appBar: PreferredSize(
        child: PostDetailAppBar(
          onTapBack: () => _onTapBack(context),
          onTapSeeMore: () => _onTapSeeMore(context),
        ),
        preferredSize: Size.fromHeight(32),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Flex(
              mainAxisSize: MainAxisSize.max,
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
                Container(child: imageSliderWidget, height: 150),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onTapSeeMore(BuildContext context) {}
}
