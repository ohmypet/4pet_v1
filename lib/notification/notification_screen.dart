part of petisland.notification;

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationBloc bloc = DI.get(NotificationBloc);

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
    final List<Notification> items = state.items;
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final Notification notification = items[index];
        return Container(
          height: 15,
          width: 15,
          color: TColors.water_melon,
        );
      },
    );
  }

  Widget buildDefaultNotification() {
    return Container(
      height: 15,
      width: 15,
      color: TColors.red,
    );
  }
}
