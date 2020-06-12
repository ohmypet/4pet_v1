part of petisland.pet_feed.widget.rescue;

class RescueListing extends TStatefulWidget {
  final ValueChanged<String> onTapRescuePost;
  final VoidCallback onTapCreateRescuePost;

  const RescueListing({
    Key key,
    this.onTapRescuePost,
    this.onTapCreateRescuePost,
  }) : super(key: key);

  @override
  TState<RescueListing> createState() => _RescueListingState();
}

class _RescueListingState extends TState<RescueListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: PanelDescriptionBar(
              title: 'Need rescue',
              onTapSeeMore: _onTapSeeMore,
            ),
          ),
          const SizedBox(height: 5),
          Flexible(child: _buildRescuePostSlider()),
        ],
      ),
    );
  }

  void _handleOnTapClick() {
    if (widget.onTapRescuePost != null) {
      widget.onTapRescuePost(ThinId.randomId());
    }
  }

  void _onTapSeeMore() {}

  Widget _buildRescuePostSlider() {
    return ListView.separated(
      itemCount: 20,
      shrinkWrap: false,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemBuilder: _buildPreviewRescuePost,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 15);
      },
    );
  }

  Widget _buildPreviewRescuePost(BuildContext context, int index) {
    return PreviewRescuePost(
      rescue: Rescue(
        rescueImages: [
          RescueImage(
            id: ThinId.randomId(),
            image: PetImage(
              id: ThinId.randomId(),
              url: 'https://github.com/tvc12.png',
            ),
          ),
        ],
      ),
    );
  }
}

class PreviewRescuePost extends StatelessWidget {
  final Rescue rescue;
  final ValueChanged<String> onTapRescuePost;

  const PreviewRescuePost({Key key, @required this.rescue, this.onTapRescuePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          PostImageWidget(imageUrl: rescue.firstImage, isSquare: false),
        ],
      ),
    );
  }

  void onTap() {}
}
