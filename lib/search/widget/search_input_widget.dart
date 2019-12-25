part of petisland.search.widget;

class SearchInputWidget extends StatefulWidget {
  final ValueChanged<String> onTextChanged;
  final TextEditingController controller;

  const SearchInputWidget({Key key, this.onTextChanged, this.controller})
      : super(key: key);

  @override
  _SearchInputWidgetState createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  TextEditingController controller;

  bool get hasIconClear => controller.text?.isNotEmpty == true;

  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: TColors.text_white,
      ),
      constraints: BoxConstraints(maxHeight: 150),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: controller,
              style: TTextStyles.light(fontSize: 16),
              textInputAction: TextInputAction.search,
              maxLines: 1,
              onChanged: _onTapChanged,
              cursorColor: theme.primaryColor,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  suffixIcon: hasIconClear ? _buildIconClear(context) : null,
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconClear(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: _clearText,
      child: Container(
        decoration: BoxDecoration(
          color: TColors.white,
          shape: BoxShape.circle,
          boxShadow: TShadows.smallShadow,
        ),
        margin: const EdgeInsets.all(12),
        child: Icon(
          Icons.clear,
          size: 16,
          color: theme.primaryColor,
        ),
      ),
    );
  }

  void _clearText() {
    controller.value = TextEditingValue.empty;

    if (mounted) setState(() {});
  }

  void _onTapChanged(String value) {
    if (value.length < 2 && mounted) setState(() {});
    if (widget.onTextChanged != null) widget.onTextChanged(value);
  }
}
