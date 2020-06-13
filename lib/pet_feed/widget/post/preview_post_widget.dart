part of petisland.pet_feed.widget.post;

enum ImageSources {
  Local,
  Server,
}

typedef TapImage = void Function(String, ImageSources);

class PreviewPostWidget extends StatelessWidget {
  final Post item;
  final TapImage onTapImage;

  const PreviewPostWidget({Key key, @required this.item, this.onTapImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget image = Flexible(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        child: PostImageWidget(imageUrl: item.firstImage, onTapImage: onTapImage),
        alignment: Alignment.centerLeft,
      ),
    );
    final Widget description = Expanded(
      child: _buildInfo(context, item),
      flex: 5,
    );
    return Flex(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      direction: Axis.horizontal,
      children: <Widget>[
        image,
        description,
      ],
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
          Flexible(flex: 3, child: PostTitleWidget(title: title)),
          const SizedBox(height: 5),
          Flexible(child: _PostUserInfoWidget(account: account)),
          Flexible(child: PostMoneyWidget(money: price)),
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PostLocationWidget(location: location),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PostTimeWidget(time: time),
            ),
          ),
        ],
      ),
    );
  }
}
