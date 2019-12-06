part of petisland.post.post_edit.widget;

class PhonePostInput extends TStatelessWidget {
  final PostEditBloc bloc;

  PhonePostInput(this.bloc);

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
            TextField(
              keyboardType: TextInputType.phone,
              onChanged: (String text) {
                bloc.phoneNumber = text;
              },
            )
          ],
        ),
      ),
    );
  }
}
