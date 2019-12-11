part of petisland.pet_feed;

class PetFeedScreen extends TStatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
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
      body: Container(color: TColors.water_melon),
    );
  }

  void _onCreatePost(BuildContext context) {
    void _onTapCreatePost(PostModal post, List<String> images) {
      Navigator.of(context).pop();
      DI.get<WorkerUpload>(WorkerUpload).uploadPost(post, images);
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
