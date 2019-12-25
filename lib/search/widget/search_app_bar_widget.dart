part of petisland.search.widget;

class SearchAppBarWidget extends StatefulWidget {
  final VoidCallback onTapBack;

  SearchAppBarWidget({Key key, this.onTapBack}) : super(key: key);

  @override
  _SearchAppBarWidgetState createState() => _SearchAppBarWidgetState();
}

class _SearchAppBarWidgetState extends State<SearchAppBarWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: _onTap,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: SearchInputWidget(controller: controller),
          ),
        ),
      ],
    );
  }

  void _onTap() {
    if (widget.onTapBack != null) {
      widget.onTapBack();
    }
  }
}
