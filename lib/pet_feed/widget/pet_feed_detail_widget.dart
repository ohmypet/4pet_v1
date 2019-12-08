part of petisland.pet_feed.widget;

class PetFeedDetailWidget extends StatefulWidget {
  final PetFeedController controller;

  const PetFeedDetailWidget({
    @required this.controller,
    Key key,
  }) : super(key: key);

  @override
  _PetFeedDetailWidgetState createState() => _PetFeedDetailWidgetState();
}

class _PetFeedDetailWidgetState extends State<PetFeedDetailWidget> {
  List<Item> items;
  bool maybeRetrievePost = true;

  PetFeedController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    items = controller.getItems();
    controller
      ..setListener(_onItemChange)
      ..retrievePosts();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final Item item = items[index];
        if (item is Panel) {
          return renderPanel(item);
        } else {
          return renderPostDetail(item);
        }
      },
      itemCount: items.length,
    );
  }

  void _onItemChange(PetFeedState state) {
    if (state is LoadPostSucceed) {
      setState(() {
        items = state.items;
        maybeRetrievePost = state.maybeRetrievePost;
      });
    }
  }
}

Widget renderPanel(Panel item) {
  if (item.type == "Trending") {
    return TrendingPanelWidget(item);
  }

  return TrendingPanelWidget(item);
}
