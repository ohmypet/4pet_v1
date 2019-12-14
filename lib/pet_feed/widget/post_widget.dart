part of petisland.pet_feed.widget;

class PostWidget extends PostItemRender<Post> {
  PostWidget(Post item) : super(item);

  @override
  Widget build(BuildContext context) {
    final Widget image = Flexible(
      flex: 3,
      child: Align(
        child: _buildImage(item),
        alignment: Alignment.centerLeft,
      ),
    );
    final Widget description = Expanded(
      child: _buildInfo(context, item),
      flex: 5,
    );
    return InkWell(
      onTap: () => navigateToScreen(context: context, screen: PostEditScreen.edit(item)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Card(
          elevation: 2,
          borderOnForeground: false,
          child: Flex(
            mainAxisSize: MainAxisSize.max,
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Flex(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  direction: Axis.horizontal,
                  children: <Widget>[
                    image,
                    description,
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: TColors.water_melon,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccount(BuildContext context, User user) {
    Widget _buildImage(BuildContext context, User user) {
      final url = user?.avatar?.url != null ? user.avatar.url : null;
      final image =
          url != null ? TCacheImageWidget(url: url) : SvgPicture.asset(TAssets.user_avatar);
      return AspectRatio(
        child: image,
        aspectRatio: 1,
      );
    }

    Widget _buildTitle(BuildContext context, User user) {
      final username = user?.name;
      return username != null ? Text(username) : SizedBox();
    }

    if (user != null) {
      final Widget image = _buildImage(context, user);
      final Widget text = _buildTitle(context, user);
      return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          image,
          text,
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildImage(Post item) {
    String getUrlImage(List<PostImage> images) {
      final PostImage image =
          images.firstWhere((PostImage image) => image.image.url != null, orElse: () => null);
      return image?.image?.url;
    }

    final String imageUrl = getUrlImage(item.postImages);

    return AspectRatio(
      child: TCacheImageWidget(url: imageUrl),
      aspectRatio: 1,
    );
  }

  Widget _buildInfo(BuildContext context, Post item) {
    final String title = item.title;
    final Account account = item.account;
    final double price = item.price;
    final String location = item.location;
    final DateTime time = item.createAt;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            child: _buildTitleWidget(context, title),
            flex: 3,
          ),
          Flexible(child: _buildAccount(context, account?.user)),
          Flexible(child: _buildPriceWidget(context, price)),
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildLocation(context, location),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildTime(context, time),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleWidget(BuildContext context, String title) {
    final ThemeData theme = Theme.of(context);

    title ??= '';
    return Text(
      title,
      maxLines: 2,
      style: theme.textTheme.body2.copyWith(
        color: theme.accentColor,
        fontSize: 18,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
        height: 1.4,
      ),
    );
  }

  Widget _buildPriceWidget(BuildContext context, double money) {
    final ThemeData theme = Theme.of(context);
    money ??= -1;
    money = money > 0 ? money : -1;
    FlutterMoneyFormatter formatter = FlutterMoneyFormatter(amount: money);
    return Text(
      money.isNegative ? 'Miễn phí' : '${formatter.output.withoutFractionDigits} đ',
      style: theme.textTheme.display4.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: theme.primaryColor,
      ),
    );
  }

  Widget _buildLocation(BuildContext context, String address) {
    final ThemeData theme = Theme.of(context);
    return address?.isNotEmpty == true
        ? Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 14,
                color: theme.accentColor.withAlpha(128),
              ),
              SizedBox(width: 2),
              Text(
                address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.display4.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.accentColor.withAlpha(128),
                ),
              ),
            ],
          )
        : SizedBox();
  }

  Widget _buildTime(BuildContext context, DateTime time) {
    final ThemeData theme = Theme.of(context);
    return time != null
        ? Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Icon(
                Icons.timer,
                size: 14,
                color: theme.accentColor.withAlpha(128),
              ),
              SizedBox(width: 2),
              Text(
                TimeUtils.getTimeAgo(time),
                style: theme.textTheme.display4.copyWith(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: theme.accentColor.withAlpha(128),
                    height: 1.2),
              ),
            ],
          )
        : SizedBox();
  }
}
