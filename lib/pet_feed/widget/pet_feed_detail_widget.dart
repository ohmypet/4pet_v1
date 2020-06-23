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

class _PetFeedDetailWidgetState extends TState<PetFeedDetailWidget> {
  List<Item> items;
  bool maybeRetrievePost = true;

  RefreshController refreshController;
  PetFeedController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: maybeRetrievePost,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: items.length + 1,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (BuildContext context, int index) {
          if (index < items.length) {
            final Item item = items[index];
            if (item is Panel) {
              return renderPanel(item, reRender: reRender);
            } else {
              return renderPostDetail(item, reRender: reRender);
            }
          } else
            return const SizedBox(height: 75);
        },
        separatorBuilder: (_, int index) {
          return SizedBox(height: 15);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    items = controller.getItems();
    controller.setListener(_onItemChange);
    refreshController = RefreshController(initialRefresh: controller.getItems().isEmpty);
  }

  Widget renderPanel(Panel item, {VoidCallback reRender}) {
    return PostPanelDetailWidget(item, reRender: reRender);
  }

  void reRender() {
    setState(() {});
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

    if (state is CreatePostSuccess) {
      showSnackBar(context, state.message, TColors.green);
    }

    if (state is CreatePostError) {
      showErrorSnackBar(content: 'Something went wrong, try again later!', context: context);
    }
  }

  void _onLoading() {
    controller.retrievePosts();
  }

  void _onRefresh() {
    controller.reload();
  }
}
