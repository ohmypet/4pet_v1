part of petisland.common.widgets;


class UserInputWidget extends TStatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  final Widget icon;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final VoidCallback onSubmit;
  final int maxLines;
  final TextAlign textAlign;
  final void Function(String) onChange;
  final bool enabled;

  UserInputWidget(
    this.controller, {
    Key key,
    this.hintText,
    this.isObscureText = false,
    this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.onSubmit,
    this.onChange,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        enabled: enabled,
        controller: controller,
        focusNode: focusNode,
        style: themeData.textTheme.bodyText2,
        maxLines: maxLines,
        keyboardType: keyboardType,
        autocorrect: false,
        cursorColor: themeData.primaryColor,
        textInputAction: TextInputAction.next,
        obscureText: isObscureText,
        onEditingComplete: onSubmit,
        onSubmitted: onSubmit != null ? (_) => onSubmit() : null,
        onChanged: onChange != null ? (_) => onChange(_) : null,
        textAlign: textAlign ?? TextAlign.start,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          hintText: hintText,
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
