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
            elevation: 0,
            backgroundColor: Colors.white,
            actions: <Widget>[
              TCircleButton(icon: Icon(Icons.search)),
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
    void _onTapCreatePost(PostModal post, List<String> images) {
      Navigator.of(context).pop();
      DI.get<TWorker>(TWorker).uploadPost(post, images);
    }

    navigateToScreen(
      context: context,
      screen: PostEditScreen.create(
        onSendTap: _onTapCreatePost,
      ),
      screenName: PostEditScreen.name,
    );
  }
}
