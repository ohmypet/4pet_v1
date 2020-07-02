part of petisland.post.screen.widget;

enum OptionType { Edit, Delete, Leave, Report, Close, ReOpen }

class PostDetailAppBar extends StatelessWidget {
  final VoidCallback onTapBack;
  final ValueChanged<OptionType> onSelected;
  final bool isOwner;
  final bool showReport;
  final bool showLeave;
  final bool showClose;
  final bool showReOpen;

  const PostDetailAppBar({
    Key key,
    this.onTapBack,
    this.onSelected,
    this.isOwner = false,
    this.showReport = true,
    this.showLeave = false,
    this.showClose = false,
    this.showReOpen = false,
  }) : super(key: key);

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
    MapEntry(OptionType.Leave, 'Leave'),
    MapEntry(OptionType.ReOpen, 'Re-open'),
    MapEntry(OptionType.Close, 'Close'),
    MapEntry(OptionType.Edit, 'Edit'),
    MapEntry(OptionType.Delete, 'Delete'),
    MapEntry(OptionType.Report, 'Report'),
  ];

  List<PopupMenuEntry<OptionType>> _buildMenu(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return items.map(
      (item) {
        bool enable = isEnable(item.key);

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

  bool isEnable(OptionType key) {
    switch (key) {
      case OptionType.Report:
        return !isOwner && showReport; //Can't report myself!!
        break;
      case OptionType.Edit:
      case OptionType.Delete:
        return isOwner;
        break;
      case OptionType.Leave:
        return !isOwner && showLeave; //Can't leave my post!!
        break;
      case OptionType.Close:
        return !isOwner && showClose;
        break;
      case OptionType.ReOpen:
        return !isOwner && showReOpen;
        break;
      default:
        return true;
    }
  }
}
