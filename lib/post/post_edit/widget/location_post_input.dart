part of petisland.post.post_edit.widget;

class LocationPostInput extends TStatelessWidget {
  final TextEditingController locationController;

  LocationPostInput(this.locationController);

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
              'Địa chỉ',
              style: TTextStyles.bold(
                fontSize: 18,
              ).copyWith(
                fontFamily: FontFamilies.thabit,
              ),
            ),
            TextField(
              controller: locationController,
            )
          ],
        ),
      ),
    );
  }
}
