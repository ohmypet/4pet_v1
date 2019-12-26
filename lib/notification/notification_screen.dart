part of petisland.notification;

class NotificationScreen extends TStatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends TState<NotificationScreen> {
  final NotificationBloc bloc = DI.get(NotificationBloc);
  final Random random = DI.get(Random);
  final RefreshController controller = RefreshController();
  @override
  void initState() {
    super.initState();
    bloc.startListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.white,
        title: Text(
          'Thông báo',
          style: TTextStyles.bold(fontSize: 18),
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        bloc: bloc,
        condition: (_, state) => state is ReloadNotificationUI,
        builder: _buildNotification,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.stopListener();
  }

  Widget _buildNotification(BuildContext context, NotificationState state) {
    if (state is ReloadNotificationUI) {
      return _buildNotificationWidget(state);
    } else {
      return buildDefaultNotification();
    }
  }

  Widget _buildNotificationWidget(ReloadNotificationUI state) {
    final List<PetNotification> items = state.items;
    return BlocListener<NotificationBloc, NotificationState>(
      bloc: bloc,
      listener: _onNotificationChanged,
      child: SmartRefresher(
        controller: controller,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: items.length,
          itemBuilder: (_, index) {
            final PetNotification notification = items[index];
            return NotificationWidget(
              item: notification,
              onTap: () => _onTap(notification),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }

  Widget buildDefaultNotification() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: kToolbarHeight, horizontal: 20),
      itemCount: random.nextInt(15) + 5,
      itemBuilder: (_, index) {
        return NotificationDefaultWidget();
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  void _onRefresh() {
    bloc.retrieveNotification();
  }

  void _onLoading() {
    bloc.getNotification();
  }

  void _onNotificationChanged(BuildContext context, NotificationState state) {
    if (state is! ReloadNotificationUI) return;
    if (controller.isLoading) {
      controller.loadComplete();
    }
    if (controller.isRefresh) {
      controller.refreshCompleted();
    }
  }

  void _onTap(PetNotification notification) {
    // if (!notification.isRead) 
    bloc.readNotification(notification.id);
    setState(() {
      notification.isRead = true;
    });
    // navigateToScreen(
    //   context: context,
    //   screen: PetCa
    // );
  }
}
