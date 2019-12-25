part of petisland.profile.widget;

class SettingOptionWidget extends StatelessWidget {
  final String title;
  final Widget icon;
  final Widget trailing;
  final VoidCallback onTap;

  const SettingOptionWidget(
      {Key key, @required this.title, Widget icon, Widget trailing, this.onTap})
      : this.icon = icon ?? const SizedBox(),
        this.trailing = trailing ?? const SizedBox(),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final text = DefaultTextStyle.merge(
      style: TTextStyles.semi(fontSize: 16),
      textAlign: TextAlign.justify,
      maxLines: 1,
      child: Text(title),
    );
    return InkWell(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.horizontal,
          children: <Widget>[
            icon,
            SizedBox(width: 10),
            Expanded(child: text),
            Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (onTap != null) onTap();
  }
}
