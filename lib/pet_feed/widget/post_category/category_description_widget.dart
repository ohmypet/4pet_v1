part of petisland.pet_feed.widget.post_category.dart;

class _CategoryDescriptionWidget extends StatelessWidget {
  final PetCategory item;

  const _CategoryDescriptionWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = item.name ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        gradient: TGradients.shortGradient,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: DefaultTextStyle(
          style: TTextStyles.semi(
            color: TColors.white,
            fontSize: 22,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          child: Text(name),
        ),
      ),
    );
  }
}
