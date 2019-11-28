part of petisland.post.post_edit.widget;

class SendWidget extends TStatelessWidget {
  final Function() onPressSend;

  SendWidget({@required this.onPressSend});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      height: 50,
      color: themeData.primaryColor,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.all(9),
            icon: Icon(
              Icons.send,
              color: themeData.buttonColor,
            ),
            onPressed: onPressSend != null ? onPressSend : () {},
          )
        ],
      ),
    );
  }
}
