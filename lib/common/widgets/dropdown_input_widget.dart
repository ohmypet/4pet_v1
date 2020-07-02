part of petisland.common.widgets;

class DropDownInputWidget extends TStatelessWidget {
  final String title;
  final bool isRequired;
  final List<String> data;
  final int initSelectedItem;
  final ValueChanged<int> onSelectedChanged;

  const DropDownInputWidget({
    Key key,
    this.title,
    this.isRequired = false,
    @required this.data,
    this.initSelectedItem = 0,
    this.onSelectedChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 13, right: 5),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: <Widget>[
          TitleWidget(title: title, isRequired: isRequired),
          TDropDown.builder(
            initSelectedItem: initSelectedItem,
            itemCount: data.length,
            onSelectedChanged: _onSelectedChanged,
            builder: _builDescription,
          )
        ],
      ),
    );
  }

  void _onSelectedChanged(int index) {
    if (onSelectedChanged != null) {
      onSelectedChanged(index);
    }
  }

  Widget _builDescription(BuildContext context, int index) {
    final theme = Theme.of(context);

    return Text(
      data[index],
      style: theme.textTheme.headline6.copyWith(
        fontSize: 16,
        color: theme.accentColor,
      ),
    );
  }
}
