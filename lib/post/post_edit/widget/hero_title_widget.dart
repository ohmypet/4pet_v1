part of petisland.post.post_edit.widget;

class HeroTitleWidget extends StatelessWidget {
  final int heroes;

  const HeroTitleWidget({Key key, @required this.heroes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = heroes < 1 ? 'Unlimited Heores' : 'Only $heroes Heroes';
    return Flex(
      direction: Axis.horizontal,
      children: [
        Icon(
          Icons.person_pin_circle,
          size: 14,
          color: TColors.dark_pink,
        ),
        const SizedBox(width: 2),
        Text(
          title,
          style: TTextStyles.normal(
            fontSize: 13,
            color: TColors.dark_pink,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
