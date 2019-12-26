part of petisland.notification;

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationBloc bloc = DI.get(NotificationBloc);
  final Random random = DI.get(Random);
  @override
  void initState() {
    super.initState();
    bloc.startListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    if (state is ReloadNotificationUI)
      return _buildNotificationWidget(state);
    else
      return buildDefaultNotification();
  }

  Widget _buildNotificationWidget(ReloadNotificationUI state) {
    final List<PetNotification> items = state.items;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: kToolbarHeight, horizontal: 20),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final PetNotification notification = items[index];
        return NotificationWidget(item: notification);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
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
}
