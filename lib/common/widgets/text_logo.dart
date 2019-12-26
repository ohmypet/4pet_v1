part of petisland.common.widgets;

class TextLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Pet',
          style: TTextStyles.normal(fontSize: 24, color: TColors.water_melon),
        ),
        TextSpan(
          text: 'island',
          style: TTextStyles.normal(fontSize: 24, color: TColors.scarlet_gum),
        ),
      ]),
    );
//    return Text(
//      'Pet',
//      style: TTextStyles.normal(fontSize: 24, color: TColors.water_melon),
//    );
  }
}
