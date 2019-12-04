part of petisland.post.post_edit.widget;

class TitlePostInput extends TStatelessWidget {
  final PostEditBloc bloc;

  TitlePostInput(this.bloc);

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
              style: TTextStyles.bold(
                fontSize: 18,
              ).copyWith(
                fontFamily: FontFamilies.thabit,
              ),
            ),
            TextField(
              onChanged: (String text) {
                bloc.inputChange(text);
              },
            )
          ],
        ),
      ),
    );
  }
}
