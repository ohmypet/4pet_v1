part of petisland.pet_feed.widget.rescue;

class PreviewRescuePostWidget extends StatelessWidget {
  final Rescue rescue;
  final ValueChanged<String> onTapRescuePost;

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
              decoration: BoxDecoration(gradient: TGradients.defaultGradient),
            ),
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
            )
          ],
        ),
      ),
    );
  }

  void onTap() {}
}
