part of petisland.post.post_edit.widget;

class TitlePostInput extends StatefulWidget {
  final PostEditBloc bloc;

  TitlePostInput(this.bloc);

  @override
  _TitlePostInputState createState() => _TitlePostInputState();
}

class _TitlePostInputState extends State<TitlePostInput> {
  final TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    textController.text = widget.bloc.title;
  }
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(left: 13, right: 5),
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              'Tiêu đề',
              style: TTextStyles.semi(
                fontSize: 18,
              ).copyWith(
                fontFamily: FontFamilies.thabit,
              ),
            ),
            UserInputWidget(
              textController,
              hintText: 'Nhập tiêu đề...',
              onChange: (String text) {
                widget.bloc.inputChange(text);
              },
            )
          ],
        ),
      ),
    );
  }
}
