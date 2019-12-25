part of petisland.home_page.widget.bottom_bar;

class BottomBarWidget extends TStatefulWidget {
  final BottomItemBuilder iconBuilder;
  final List<Widget> children;
  final int intIndex;
  final NavigationBarBloc bloc;

  const BottomBarWidget(
      {@required this.bloc,
      @required this.iconBuilder,
      @required this.children,
      this.intIndex = 0,
      Key key})
      : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends TState<BottomBarWidget>
    with SingleTickerProviderStateMixin {
  BottomItemBuilder get iconBuilder => widget.iconBuilder;

  double height;

  List<Widget> get children => widget.children;
  NavigationBarBloc get bloc => widget.bloc;

  @protected
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: widget.intIndex,
      vsync: this,
      length: children.length,
    );

    DI.get<BottomBarController>(BottomBarController).addController(tabController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocListener<NavigationBarBloc, NavigationBarState>(
        bloc: bloc,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: height,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                spreadRadius: 6,
                color: TColors.black.withAlpha(25),
                blurRadius: 6,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: BottomAppBar(
            child: BottomBarSelector(
              controller: tabController,
              builder: iconBuilder,
            ),
          ),
        ),
        listener: _onNavigationBarChanged,
      ),
      body: TabBarView(
        controller: tabController,
        children: children,
      ),
    );
  }

  @override
  void dispose() {
    DI.get<BottomBarController>(BottomBarController).removeController();
    tabController.dispose();
    super.dispose();
  }

  void _onNavigationBarChanged(BuildContext context, NavigationBarState state) {
    setState(() {
      height = state is HideNavigationBar ? 0 : null;
    });
  }
}
