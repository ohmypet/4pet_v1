import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/common/widgets/widgets.dart';

class DropdownInputWidget<T> extends StatelessWidget {
  final ValueChanged<T> onSelected;
  final DropdownSearchOnFind<T> onFind;
  final DropdownSearchItemAsString<T> itemAsString;
  final String title;
  final bool isRequired;
  final String hintText;

  const DropdownInputWidget({
    Key key,
    this.onSelected,
    @required this.onFind,
    this.itemAsString,
    @required this.title,
    this.isRequired = false,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final decorator = InputDecoration(
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
    );
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
                dialogTheme: theme.dialogTheme.copyWith(
                  contentTextStyle: TTextStyles.medium(fontSize: 14),
                ),
                textTheme: theme.textTheme.copyWith(
                  subtitle1: TTextStyles.medium(fontSize: 15),
                  subtitle2: TTextStyles.medium(fontSize: 14),
                  headline1: TTextStyles.medium(fontSize: 14),
                  headline2: TTextStyles.medium(fontSize: 14),
                  headline3: TTextStyles.medium(fontSize: 14),
                  headline4: TTextStyles.medium(fontSize: 14),
                  headline5: TTextStyles.medium(fontSize: 14),
                  headline6: TTextStyles.medium(fontSize: 14),
                  bodyText1: TTextStyles.medium(fontSize: 14),
                  bodyText2: TTextStyles.medium(fontSize: 14),
                  caption: TTextStyles.medium(fontSize: 14),
                  button: TTextStyles.medium(fontSize: 14),
                  overline: TTextStyles.medium(fontSize: 14),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
