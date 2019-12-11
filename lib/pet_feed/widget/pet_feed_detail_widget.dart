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
  RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    items = controller.getItems();
    controller.setListener(_onItemChange);
    refreshController = RefreshController(initialRefresh: controller.getItems().isEmpty);
    // WidgetsBinding.instance.addPersistentFrameCallback((_) {
    //   if (controller.getItems().isEmpty == true) refreshController.requestRefresh();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.separated(
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
      ),
    );
  }

  void _onItemChange(PetFeedState state) {
    if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
    if (refreshController.isRefresh) {
      refreshController.refreshCompleted();
    }

    if (state is LoadPostSucceed) {
      setState(() {
        items = state.items;
        maybeRetrievePost = state.maybeRetrievePost;
      });
    }
  }

  void _onRefresh() {
    controller.reload();
  }

  void _onLoading() {
    controller.retrievePosts();
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
