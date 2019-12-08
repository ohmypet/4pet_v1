part of petisland.pet_feed;

class PetFeedScreen extends StatefulWidget {
  @override
  _PetFeedScreenState createState() => _PetFeedScreenState();
}

class _PetFeedScreenState extends State<PetFeedScreen> {
  final PetFeedController controller = PetFeedControllerImpl();

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
      body: PetFeedDetailWidget(controller: controller),
    );
  }

  void _onCreatePost(BuildContext context) {
    // TODO(HaoNguyen): Navigate to pet feed in there

    // navigateToScreen(
    //   context: context,
    //   screen: ,
    // );
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
