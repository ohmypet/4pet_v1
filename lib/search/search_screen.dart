part of petisland.search;

class SearchScreen extends TStatefulWidget {
  final List<Post> initItems;

  static final name = '/SearchScreen';

  const SearchScreen({Key key, this.initItems = const []}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends TState<SearchScreen> {
  final List<Post> items = [];

  @override
  void initState() {
    super.initState();
    items.addAll(widget.initItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            SearchAppBarWidget(
              onTapBack: () => _onTapBack(context),
            ),
            Expanded(
              child: Container(
                color: TColors.water_melon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapBack(BuildContext context) {
    closeUntil(context, '/');
  }
}
