part of petisland.pet_feed.widget.rescue;

class RescueListing extends TStatefulWidget {
  final ValueChanged<String> onTapRescuePost;
  final VoidCallback onTapCreateRescuePost;
  final RescueListingBloc listingBloc;

  const RescueListing({
    Key key,
    @required this.listingBloc,
    this.onTapRescuePost,
    this.onTapCreateRescuePost,
  }) : super(key: key);

  @override
  TState<RescueListing> createState() => _RescueListingState();
}

class _RescueListingState extends TState<RescueListing> {
  RescueListingBloc get bloc => widget.listingBloc;
  static const ReviewRescueDefaultWidget rescueDefault = const ReviewRescueDefaultWidget();
  
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
              title: 'Need help',
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
    return BlocBuilder(
      bloc: bloc,
      condition: (_, state) => state is ReloadListingState,
      builder: (BuildContext context, state) {
        return ListView.separated(
          itemCount: 20,
          shrinkWrap: false,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          itemBuilder: (_, index) => rescueDefault,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 10);
          },
        );
      },
    );
  }

  Widget _buildPreviewRescuePost(BuildContext context, int index) {
    return PreviewRescuePostWidget(
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
        aspectRatio: 0.75, // 3/4
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
            )
          ],
        ),
      ),
    );
  }

  void onTap() {}
}

class ReviewRescueDefaultWidget extends StatelessWidget {
  const ReviewRescueDefaultWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75, // 3/4
      child: Stack(
        children: <Widget>[
          TShimmerLoading(),
          Container(
            margin: const EdgeInsets.all(4),
            alignment: Alignment.topRight,
            child: CircleColorWidget(
              child: SizedBox(
                width: 24,
                height: 24,
                child: TShimmerLoading.circle(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
