part of petisland.home_page;

class HomePageScreen extends StatefulWidget {
  final AuthenticationBloc bloc;

  HomePageScreen(this.bloc, {Key key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final List<BottomBarItemWidget> tabs = <BottomBarItemWidget>[
    BottomBarItemWidget(Icons.home),
    BottomBarItemWidget(Icons.notifications),
    BottomBarItemWidget(Icons.sms),
    BottomBarItemWidget(Icons.person)
  ];

  @override
  Widget build(BuildContext context) {
    return BottomBarWidget(
      children: <Widget>[
        PetFeedScreen(),
        NotificationScreen(),
        ChatScreen(),
        SettingScreen(bloc: widget.bloc),
      ],
      iconBuilder: (_, int index, bool isSelected) {
        return isSelected ? tabs[index].buildSeletect(context) : tabs[index].buildUnSelect(context);
      },
    );
  }
}
