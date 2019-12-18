part of petisland.post.post_edit.widget;

class PricePostInput extends StatefulWidget {
  final PostEditBloc bloc;

  PricePostInput(this.bloc);

  @override
  _PricePostInputState createState() => _PricePostInputState();
}

class _PricePostInputState extends State<PricePostInput> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.bloc.price > 0) textController.text = widget.bloc.price.toString();
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
            _TitleWidget(title: 'Giá', isRequired: false),
            UserInputWidget(
              textController,
              hintText: 'Nhập giá tiền...',
              keyboardType: TextInputType.number,
              onChange: (String text) {
                if (text.trim() == null || text.trim().isEmpty || double.parse(text.trim()) <= 0) {
                  widget.bloc.priceChange(-1);
                } else {
                  widget.bloc.priceChange(double.parse(text.trim()));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
