part of petisland.home_page;

class HomePageScreen extends TStatelessWidget {
  final AuthenticationBloc bloc;

  HomePageScreen(this.bloc, {Key key}) : super(key: key);
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
        MessageScreen(),
        SettingScreen(bloc: bloc),
      ],
      iconBulder: (_, int index, bool isSelected) {
        return isSelected ? tabs[index].buildSeletect(context) : tabs[index].buildUnSelect(context);
      },
    );
  }
}
