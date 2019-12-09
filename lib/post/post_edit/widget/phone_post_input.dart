part of petisland.post.post_edit.widget;

class PhonePostInput extends TStatefulWidget {
  final PostEditBloc bloc;

  PhonePostInput(this.bloc);

  @override
  _PhonePostInputState createState() => _PhonePostInputState();
}

class _PhonePostInputState extends TState<PhonePostInput> {
  final TextEditingController textController = TextEditingController();
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
              'Số điện thoại',
              style: TTextStyles.bold(
                fontSize: 18,
              ).copyWith(
                fontFamily: FontFamilies.thabit,
              ),
            ),
            UserInputWidget(
              textController,
              hintText: "Nhập điện thoại...",
              keyboardType: TextInputType.phone,
              onChange: (String text) {
                widget.bloc.phoneNumber = text;
              },
            )
          ],
        ),
      ),
    );
  }
}
