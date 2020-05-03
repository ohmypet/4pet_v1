part of petisland.pet_feed;

class PetFeedScreen extends TStatefulWidget {
  @override
  _PetFeedScreenState createState() => _PetFeedScreenState();
}

class _PetFeedScreenState extends TState<PetFeedScreen> {
  final PetFeedController controller = DI.get(PetFeedController);

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
              TCircleButton(icon: Icon(Icons.search), onTap: _onTapSearch),
              SizedBox(width: 7),
              TCircleButton(
                icon: Icon(Icons.add),
                onTap: () => _onCreatePost(context),
              ),
              SizedBox(width: 15),
            ],
          )
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

  void _onTapSearch() {
    // TODO(tvc12): navigate to search
    navigateToScreen(
      context: context,
      screen: SearchScreen(),
      screenName: SearchScreen.name,
    );
  }
}
