part of petisland.profile.screen;

class MyPostScreen extends StatefulWidget {
  static const String name = '/MyPostScreen';
  @override
  _MyPostScreenState createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  final MyPostBloc bloc = DI.get(MyPostBloc);
  final RefreshController controller = RefreshController();

  void initState() {
    super.initState();
    bloc.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài viết của bạn', style: TTextStyles.bold(fontSize: 18)),
        centerTitle: true,
        backgroundColor: TColors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: TColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<MyPostBloc, MyPostState>(
        bloc: bloc,
        listener: _onListChanged,
        child: BlocBuilder<MyPostBloc, MyPostState>(
          bloc: bloc,
          condition: (_, state) => state is ReloadUI,
          builder: _buildUIState,
        ),
      ),
    );
  }

  Widget _buildUIState(BuildContext context, MyPostState state) {
    if (state is ReloadUI) {
      final items = state.items;
      return SmartRefresher(
        controller: controller,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
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

  void _onRefresh() {
    bloc.reload();
  }

  void _onLoading() {
    bloc.retrievePost();
  }

  void _onListChanged(BuildContext context, MyPostState state) {
    if (state is! ReloadUI) return;
    if (controller.isLoading) {
      controller.loadComplete();
    }
    if (controller.isRefresh) {
      controller.refreshCompleted();
    }
  }
}
