part of petisland.common.widgets;

class TDropDown extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder builder;
  final int initSelectedItem;
  final ValueChanged<int> onSelectedChanged;

  TDropDown.builder({
    @required this.itemCount,
    @required this.builder,
    this.initSelectedItem = 0,
    this.onSelectedChanged,
  });

  @override
  _TDropDownState createState() => _TDropDownState();
}

class _TDropDownState extends State<TDropDown> {
  final List<DropdownMenuItem<int>> items = <DropdownMenuItem<int>>[];
  int currentSelected;

  void initState() {
    super.initState();
    currentSelected = widget.initSelectedItem ?? 0;
    items.addAll(
      List<DropdownMenuItem<int>>.generate(
        widget.itemCount,
        (int i) => DropdownMenuItem<int>(
          value: i,
          child: Builder(builder: (context) => widget.builder(context, i)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      elevation: 1,
      iconEnabledColor: Theme.of(context).primaryColor,
      iconSize: 32,
      items: items,
      value: currentSelected,
      onChanged: _onSelectedChanged,
      isExpanded: true,
    );
  }

  void _onSelectedChanged(int value) {
    setState(() {
      currentSelected = value;
    });
    if (widget.onSelectedChanged != null) widget.onSelectedChanged(currentSelected);
  }
}
