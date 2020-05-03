part of petisland.notification.widget;

class NotificationMessageWidget extends StatelessWidget {
  final String message;
  final DateTime createdTime;
  final List<TextConfig> textConfigs;

  NotificationMessageWidget(
      {Key key, @required this.message, @required this.createdTime})
      : textConfigs = StringUtils.getTextConfigs(message),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: _buildMessageDescription(context, message),
        ),
        SizedBox(width: 15),
        Flexible(
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              TimeUtils.getTimeAgo(createdTime),
              style: TTextStyles.normal(color: TColors.black.withAlpha(128)),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMessageDescription(BuildContext context, String message) {
    return RichText(
      maxLines: 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: textConfigs.map(_buildText).toList()),
    );
  }

  TextSpan _buildText(TextConfig textConfig) {
    return TextSpan(
      text: textConfig.text + ' ',
      style: textConfig.isANotation ? bold : light,
    );
  }

  final bold =
      TTextStyles.bold(fontSize: 15, color: TColors.black.withAlpha(200));
  final light =
      TTextStyles.light(fontSize: 15, color: TColors.black.withAlpha(220));
}
