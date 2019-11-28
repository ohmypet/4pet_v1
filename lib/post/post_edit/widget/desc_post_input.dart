part of petisland.post.post_edit.widget;

class DescPostInput extends TStatelessWidget {
  final TextEditingController descriptionController;

  DescPostInput(this.descriptionController);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Container(
        padding: EdgeInsets.only(left: 13, right: 5),
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              'Mô tả',
              style: TTextStyles.bold(
                fontSize: 18,
              ).copyWith(
                fontFamily: FontFamilies.thabit,
              ),
            ),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            )
          ],
        ),
      ),
    );
  }
}
