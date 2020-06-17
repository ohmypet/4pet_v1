part of petisland.pet_feed;

class PetFeedScreen extends TStatelessWidget {
  final PetFeedController controller = DI.get(PetFeedController);
  final RescueListingBloc listingBloc = DI.get(RescueListingBloc);
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            floating: true,
            snap: true,
            title: TextLogo(),
            actions: <Widget>[
              // TODO(tvc12): Disable search feature, open in next version
              EnableWidget(
                enable: false,
                child: TCircleButton(icon: Icon(Icons.search)),
              ),
              SizedBox(width: 7),
              TCircleButton(
                icon: Icon(Icons.add),
                onTap: () => _onCreatePost(context),
              ),
              SizedBox(width: 15),
            ],
          ),
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: _buildRescueHeader(context),
          ),
          // SliverPersistentHeader(
        ];
      },
      body: PetFeedDetailWidget(controller: controller),
    );
  }

  SliverPersistentHeaderDelegate _buildRescueHeader(BuildContext context) {
    return THeaderWidget(
      minExtent: 205,
      maxExtent: 205,
      autoInsertSafeArea: false,
      child: RescueListing(
        listingBloc: listingBloc,
        onTapCreateRescuePost: () => _onTapCreatePost(context),
      ),
    );
  }

  void _onCreatePost(BuildContext context) {
    void _onTapCreatePost(PostCreateModal post, List<String> images) {
      DI.get<TWorker>(TWorker).createPost(post, images);
    }

    navigateToScreen(
      context: context,
      screen: PostEditScreen.create(onSendTap: _onTapCreatePost),
      screenName: PostEditScreen.name,
    );
  }

  void _onTapCreatePost(BuildContext context) {
    navigateToScreen(
      context: context,
      screen: RescueCreationScreen(),
      screenName: RescueCreationScreen.name,
    );
  }
}
