part of petisland.common.widgets;

class TitleInputWidget extends TStatelessWidget {
  final TextEditingController editingController;
  final String hintText;
  final String title;
  final bool isRequired;
  final int maxLines;
  final ValueChanged<String> onTextChanged;
  final TextInputType keyboardType;
  final bool enabled;
  final String subTitle;

  const TitleInputWidget({
    this.editingController,
    this.hintText,
    this.onTextChanged,
    this.title = '',
    this.isRequired = false,
    this.maxLines = 1,
    this.keyboardType,
    this.enabled = true,
    this.subTitle,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 13, right: 5),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: <Widget>[
          TitleWidget(title: title, isRequired: isRequired, subtitle: subTitle),
          UserInputWidget(
            editingController ?? TextEditingController(),
            hintText: hintText,
            onChange: onTextChanged,
            maxLines: maxLines,
            keyboardType: keyboardType,
            enabled: enabled,
          )
        ],
      ),
    );
  }
}
