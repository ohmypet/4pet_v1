part of petisland.post.post_edit.widget;

class LocationPostInput extends TStatefulWidget {
  final PostEditBloc bloc;

  LocationPostInput(this.bloc);

  @override
  _LocationPostInputState createState() => _LocationPostInputState();
}

class _LocationPostInputState extends TState<LocationPostInput> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.bloc.location;
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
            _TitleWidget(title: 'Địa chỉ', isRequired: true),
            UserInputWidget(
              textController,
              hintText: 'Nhập địa chỉ...',
              onChange: (String text) {
                widget.bloc.location = text;
                widget.bloc.priceChange(widget.bloc.price);
              },
            )
          ],
        ),
      ),
    );
  }
}
