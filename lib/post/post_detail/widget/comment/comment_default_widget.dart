part of petisland.post.screen.widget;

class _CommentLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final image = _buildImage(context);
    return Flex(
      mainAxisSize: MainAxisSize.max,
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(child: image, flex: 1),
        Flexible(child: _buildCommentDescription(), flex: 7),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return XImageLoading(
      child: Container(
        decoration: BoxDecoration(color: TColors.duck_egg_blue, shape: BoxShape.circle),
        margin: const EdgeInsets.all(5),
        child: AspectRatio(aspectRatio: 1),
      ),
    );
  }

  Widget _buildCommentDescription() {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(child: _buildLoadingName(), flex: 1),
        SizedBox(height: 5),
        Flexible(child: _buildLoadingComment(), flex: 3),
      ],
    );
  }

  Widget _buildLoadingName() {
    final random = DI.get<Random>(Random);

    return XImageLoading(
      child: Container(
        width: random.nextInt(75) + 85.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: TColors.duck_egg_blue,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildLoadingComment() {
    final random = DI.get<Random>(Random);

    return XImageLoading(
      child: Container(
        height: random.nextInt(35) + 35.0,
        decoration: BoxDecoration(
          color: TColors.duck_egg_blue,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
