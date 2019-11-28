part of petisland.post.post_edit.widget;

class PricePostInput extends TStatelessWidget {
  final PostEditBloc bloc;
  final TextEditingController priceController;

  PricePostInput(this.bloc, this.priceController);

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
              'Giá',
              style: TTextStyles.bold(
                fontSize: 18,
              ).copyWith(
                fontFamily: FontFamilies.thabit,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (String text) {
                if (text.trim().isNotEmpty) {
                  bloc.priceChange(double.parse(text));
                } else {
                  bloc.priceChange(0);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
