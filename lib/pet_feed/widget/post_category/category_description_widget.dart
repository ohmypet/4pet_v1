part of petisland.pet_feed.widget.post_category.dart;

class _CategoryDescriptionWidget extends StatelessWidget {
  final PetCategory item;

  const _CategoryDescriptionWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = item.name ?? '';
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        gradient: TGradients.shortGradient,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: DefaultTextStyle(
          style: TTextStyles.bold(color: TColors.text_white, fontSize: 24),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          child: Text(name),
        ),
      ),
    );
  }
}
