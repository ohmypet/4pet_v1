part of petisland.post.screen.widget;

enum OptionType { Edit, Delete, Click, Report }

class PostDetailAppBar extends StatelessWidget {
  final VoidCallback onTapBack;
  final ValueChanged<OptionType> onSelected;
  final bool hasPermision;

  const PostDetailAppBar(
      {Key key, this.onTapBack, this.onSelected, this.hasPermision = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: _onTapBack,
            color: theme.accentColor,
          ),
          PopupMenuButton<OptionType>(
            itemBuilder: _buildMenu,
            onSelected: _onSelectChanged,
            icon: Icon(Icons.more_vert, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }

  static final items = <MapEntry<OptionType, String>>[
    MapEntry(OptionType.Edit, 'Edit'),
    MapEntry(OptionType.Delete, 'Delete'),
    MapEntry(OptionType.Report, 'Report'),
  ];

  List<PopupMenuEntry<OptionType>> _buildMenu(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return items.map(
      (item) {
        bool enable = item.key != OptionType.Report ? hasPermision : true;
        return PopupMenuItem<OptionType>(
          value: item.key,
          enabled: enable,
          child: Text(item.value),
          textStyle: theme.textTheme.bodyText2,
        );
      },
    ).toList()
      ..removeWhere((element) => !element.enabled);
  }

  void _onTapBack() {
    if (onTapBack != null) onTapBack();
  }

  void _onSelectChanged(OptionType value) {
    if (onSelected != null) onSelected(value);
  }
}
