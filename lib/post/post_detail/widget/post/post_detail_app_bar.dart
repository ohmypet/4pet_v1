part of petisland.post.screen.widget;

enum SeeMoreType { Edit, Delete, Report }

class PostDetailAppBar extends StatelessWidget {
  final VoidCallback onTapBack;
  final ValueChanged<SeeMoreType> onTapSeeMore;
  final bool hasPermision;

  const PostDetailAppBar(
      {Key key, this.onTapBack, this.onTapSeeMore, this.hasPermision = false})
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
          PopupMenuButton<SeeMoreType>(
            itemBuilder: _buildMenu,
            onSelected: _onSelectChanged,
            icon: Icon(Icons.more_vert, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }

  static final items = <MapEntry<SeeMoreType, String>>[
    MapEntry(SeeMoreType.Edit, 'Chỉnh sửa'),
    MapEntry(SeeMoreType.Delete, 'Xóa'),
    MapEntry(SeeMoreType.Report, 'Báo cáo'),
  ];

  List<PopupMenuEntry<SeeMoreType>> _buildMenu(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return items.map(
      (item) {
        bool enable = item.key != SeeMoreType.Report ? hasPermision : true;
        return PopupMenuItem<SeeMoreType>(
          value: item.key,
          enabled: enable,
          child: Text(item.value),
          textStyle: theme.textTheme.bodyText2,
        );
      },
    ).toList();
  }

  void _onTapBack() {
    if (onTapBack != null) onTapBack();
  }

  void _onSelectChanged(SeeMoreType value) {
    if (onTapSeeMore != null) onTapSeeMore(value);
  }
}
