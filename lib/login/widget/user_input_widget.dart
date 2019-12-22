part of petisland.login.widget;

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: themeData.textTheme.body1,
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          hintText: hintText,
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
