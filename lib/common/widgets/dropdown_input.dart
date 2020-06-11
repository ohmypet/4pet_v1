part of petisland.common.widgets;

class DropdownInputWidget<T> extends StatelessWidget {
  final ValueChanged<T> onSelected;
  final DropdownSearchOnFind<T> onFind;
  final DropdownSearchItemAsString<T> itemAsString;
  final String title;
  final bool isRequired;
  final String hintText;
  final T selectedItem;

  const DropdownInputWidget({
    Key key,
    this.onSelected,
    @required this.onFind,
    this.itemAsString,
    @required this.title,
    this.isRequired = false,
    this.hintText,
    this.selectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final decorator = InputDecoration(
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
    );
    final style = TTextStyles.medium(fontSize: 15);
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 10),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          TitleWidget(title: title, isRequired: isRequired),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Theme(
              data: theme.copyWith(
                dialogTheme: theme.dialogTheme.copyWith(contentTextStyle: style),
                textTheme: theme.textTheme.copyWith(
                  subtitle1: style,
                  subtitle2: style,
                  headline1: style,
                  headline2: style,
                  headline3: style,
                  headline4: style,
                  headline5: style,
                  headline6: style,
                  bodyText1: style,
                  bodyText2: style,
                  caption: style,
                  button: style,
                  overline: style,
                ),
              ),
              child: DefaultTextStyle(
                style: TTextStyles.light(fontSize: 14),
                child: DropdownSearch<T>(
                  isFilteredOnline: true,
                  onFind: onFind,
                  filterFn: (_, __) => true,
                  onChanged: onSelected,
                  showSearchBox: true,
                  mode: Mode.BOTTOM_SHEET,
                  itemAsString: itemAsString,
                  autoFocusSearchBox: true,
                  searchBoxDecoration: decorator,
                  dropdownSearchDecoration: decorator,
                  selectedItem: selectedItem,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
