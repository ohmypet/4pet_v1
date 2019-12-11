part of petisland.pet_feed.widget;

class PostWidget extends PostItemRender<Post> {
  PostWidget(Post item) : super(item);

  @override
  Widget build(BuildContext context) {
    final Widget image = _buildImage(item);
    final Widget description = _buildInfo(context, item);
    return Container(
      height: 130,
      child: Card(
        elevation: 2,
        borderOnForeground: false,
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            image,
            description,
          ],
        ),
      ),
    );
  }

  Widget _buildImage(Post item) {
    String getUrlImage(List<PostImage> images) {
      final PostImage image =
          images.firstWhere((PostImage image) => image.image.url != null, orElse: () => null);
      return image?.image?.url;
    }

    final String imageUrl = getUrlImage(item.postImages);

    return Padding(
      padding: const EdgeInsets.all(5),
      child: AspectRatio(
        child: TCacheImageWidget(url: imageUrl),
        aspectRatio: 1,
      ),
    );
  }

  Widget _buildInfo(BuildContext context, Post item) {
    final String title = item.title;
    final double price = item.price;
    final ThemeData theme = Theme.of(context);

    return Stack(
      children: <Widget>[
        Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(child: _buildTitleWidget(context, title)),
            Flexible(child: _buildPriceWidget(context, price)),
          ],
        ),
        GestureDetector(
          onTap: _onLikes,
          child: Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Icon(Icons.favorite_border, color: theme.primaryColor),
                SizedBox(width: 5),
                Text('${item.likes}', style: theme.textTheme.title),
              ],
            ),
            alignment: Alignment.bottomRight,
          ),
        )
      ],
    );
  }

  Widget _buildTitleWidget(BuildContext context, String title) {
    final ThemeData theme = Theme.of(context);

    title ??= "";
    return Text(
      title,
      style: theme.textTheme.display2.copyWith(
        color: theme.accentColor,
        fontSize: 20,
      ),
    );
  }

  Widget _buildPriceWidget(BuildContext context, double money) {
    final ThemeData theme = Theme.of(context);
    money ??= -1;
    FlutterMoneyFormatter formatter = FlutterMoneyFormatter(amount: money);
    return Text(
      money.isNegative ? "Miễn phí" : "${formatter.output.withoutFractionDigits} đ",
      style: theme.textTheme.display1.copyWith(fontSize: 18, color: theme.primaryColor),
    );
  }

  void _onLikes() {}
}
