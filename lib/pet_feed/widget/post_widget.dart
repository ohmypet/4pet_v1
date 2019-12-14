part of petisland.pet_feed.widget;

class PostWidget extends PostItemRender<Post> {
  PostWidget(Post item) : super(item);

  @override
  Widget build(BuildContext context) {
    final Widget image = _buildImage(item);
    final Widget description = _buildInfo(context, item);
    return InkWell(
      onTap: () => navigateToScreen(context: context, screen: PostEditScreen.edit(item)),
      child: Container(
        height: 130,
        child: Card(
          elevation: 2,
          borderOnForeground: false,
          child: Flex(
            mainAxisSize: MainAxisSize.max,
            direction: Axis.horizontal,
            children: <Widget>[
              image,
              Expanded(child: description),
            ],
          ),
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
          mainAxisSize: MainAxisSize.max,
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
                Icon(Icons.person, color: theme.accentColor),
                SizedBox(width: 5),
                Text(<String>['user', 'admin'][Random().nextInt(2)], style: theme.textTheme.title),
                SizedBox(width: 7),
                Icon(Icons.favorite_border, color: theme.primaryColor),
                SizedBox(width: 5),
                Text('${item.likes}', style: theme.textTheme.title),
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),
        ),
      ],
    );
  }

  Widget _buildTitleWidget(BuildContext context, String title) {
    final ThemeData theme = Theme.of(context);

    title ??= "";
    return Text(
      title,
      maxLines: 3,
      style: theme.textTheme.display2.copyWith(
        color: theme.accentColor,
        fontSize: 20,
      ),
    );
  }

  Widget _buildPriceWidget(BuildContext context, double money) {
    final ThemeData theme = Theme.of(context);
    money ??= -1;
    money = money > 0 ? money : -1;
    FlutterMoneyFormatter formatter = FlutterMoneyFormatter(amount: money);
    return Text(
      money.isNegative ? "Miễn phí" : "${formatter.output.withoutFractionDigits} đ",
      style: theme.textTheme.display1.copyWith(fontSize: 18, color: theme.primaryColor),
    );
  }

  void _onLikes() {}
}
