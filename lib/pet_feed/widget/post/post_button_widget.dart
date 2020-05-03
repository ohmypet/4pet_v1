/**
 * @author tvc12
 * @email meomeocf98@gmail.com
 * @create date 2019-12-16 11:48:05
 * @modify date 2019-12-16 11:48:05
 * @desc [auto disable ontap when opcatiy < 0.8]
 */
part of petisland.pet_feed.widget.post;

class _PostButtonWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final double opacity;
  final VoidCallback onTap;

  const _PostButtonWidget({
    Key key,
    @required this.title,
    @required this.icon,
    this.opacity = 1,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Opacity(
      opacity: opacity,
      child: FlatButton.icon(
        padding: EdgeInsets.zero,
        label: Text(
          title,
          style: theme.textTheme.headline1.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        icon: icon,
        onPressed: opacity < 0.8 ? null : onTap,
      ),
    );
  }
}
