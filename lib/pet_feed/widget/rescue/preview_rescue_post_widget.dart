part of petisland.pet_feed.widget.rescue;

class PreviewRescuePostWidget extends StatelessWidget {
  final Rescue rescue;
  final ValueChanged<Rescue> onTapRescuePost;

  const PreviewRescuePostWidget({Key key, @required this.rescue, this.onTapRescuePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = rescue.avatar;
    final image = rescue.firstImage;
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: TConstants.ratio4y3, //4.3
        child: Stack(
          children: <Widget>[
            PostImageWidget(imageUrl: image, isSquare: false),
            Container(
              margin: const EdgeInsets.all(4),
              alignment: Alignment.topRight,
              child: CircleColorWidget(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: AvatarWidget(url: avatar),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(gradient: TGradients.darkGradient),
            ),
            _buildLocation(),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(5),
              child: _buildRescueData(),
            ),
          ],
        ),
      ),
    );
  }

  void onTap() {
    if (onTapRescuePost != null) {
      onTapRescuePost(rescue);
    }
  }

  Widget _buildRescueData() {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDescription(),
        _buildLikedAndJoinedIcon(),
      ],
    );
  }

  Widget _buildLikedAndJoinedIcon() {
    final iconLiked = rescue.isReacted == true
        ? Icon(Icons.favorite, color: TColors.water_melon, size: 12)
        : Icon(Icons.favorite_border, color: TColors.text_white, size: 12);
    final iconVolumteer = rescue.isJoined == true
        ? Icon(Icons.group, color: TColors.water_melon, size: 14)
        : Icon(Icons.group, color: TColors.text_white, size: 14);
    return Flex(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      direction: Axis.horizontal,
      children: [
        Flexible(
          child: _buildIconAndTitle(icon: iconLiked, title: rescue.likeAsString),
        ),
        Flexible(
          child: _buildIconAndTitle(icon: iconVolumteer, title: rescue.maxHeroeAsString),
        )
      ],
    );
  }

  Widget _buildIconAndTitle({@required Icon icon, @required String title}) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        icon,
        const SizedBox(width: 1),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TTextStyles.normal(
            color: TColors.text_white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      rescue.title ?? '',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TTextStyles.semi(
        color: TColors.text_white,
        fontSize: 12,
      ),
    );
  }

  Widget _buildLocation() {
    return Container(
      width: 75,
      height: 26,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: TColors.water_melon_light.withAlpha(250),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: Text(
        rescue.location,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TTextStyles.semi(
          color: TColors.text_white,
          fontSize: 12,
        ),
      ),
    );
  }
}
