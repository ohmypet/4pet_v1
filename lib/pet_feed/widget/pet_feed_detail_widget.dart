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
    controller.setListener(_onItemChange);
    if (controller.getItems().isEmpty == true) controller.retrievePosts();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemBuilder: (BuildContext context, int index) {
        final Item item = items[index];
        if (item is Panel) {
          return renderPanel(item);
        } else {
          return renderPostDetail(item);
        }
      },
      separatorBuilder: (_, int index) {
        return SizedBox(height: 15);
      },
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
  return SizedBox();
  // return Container(width: 15, height: 30, color: TColors.scarlet_gum);
//  if (item.type == "Trending") {
//    return TrendingPanelWidget(item);
//  }
//
//  return TrendingPanelWidget(item);
}
