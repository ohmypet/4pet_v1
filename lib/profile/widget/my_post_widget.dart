part of petisland.profile.widget;

class MyPostWidget extends StatefulWidget {
  @override
  _MyPostWidgetState createState() => _MyPostWidgetState();
}

class _MyPostWidgetState extends State<MyPostWidget> {
  final MyPostBloc bloc = DI.get(MyPostBloc);
  final RefreshController controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyPostBloc, MyPostState>(
      bloc: bloc,
      listener: _onListChanged,
      child: BlocBuilder<MyPostBloc, MyPostState>(
        bloc: bloc,
        condition: (_, state) => state is ReloadMyPost,
        builder: _buildUIState,
      ),
    );
  }

  void initState() {
    super.initState();
    bloc.reload();
  }

  Widget _buildUIState(BuildContext context, MyPostState state) {
    if (state is ReloadMyPost) {
      final items = state.items;
      return SmartRefresher(
        primary: true,
        controller: controller,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        physics: const ClampingScrollPhysics(),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: state.items.length,
          itemBuilder: (_, index) {
            final PanelDetail notification = items[index];
            return PostWidget(notification.postItem);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      );
    } else
      return SizedBox();
  }

  void _onListChanged(BuildContext context, MyPostState state) {
    if (state is! ReloadMyPost) return;
    if (controller.isLoading) {
      controller.loadComplete();
    }
    if (controller.isRefresh) {
      controller.refreshCompleted();
    }
  }

  void _onLoading() {
    bloc.retrievePost();
  }

  void _onRefresh() {
    bloc.reload();
  }
}
