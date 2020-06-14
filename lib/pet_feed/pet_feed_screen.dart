part of petisland.pet_feed;

class PetFeedScreen extends TStatefulWidget {
  @override
  _PetFeedScreenState createState() => _PetFeedScreenState();
}

class _PetFeedScreenState extends TState<PetFeedScreen> {
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
            pinned: true,
            floating: false,
            delegate: THeaderWidget(
              minExtent: 175,
              maxExtent: 175,
              autoInsertSafeArea: false,
              child: RescueListing(
                onTapRescuePost: _onTapPost,
                listingBloc: listingBloc,
              ),
            ),
          ),
          // SliverPersistentHeader(
        ];
      },
      body: PetFeedDetailWidget(controller: controller),
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

  void _onTapPost(String value) {
    navigateToScreen(
      context: context,
      screen: RescueCreationPost(),
    );
  }
}
