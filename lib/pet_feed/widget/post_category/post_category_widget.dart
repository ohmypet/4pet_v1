part of petisland.pet_feed.widget.post_category.dart;

class PetCategoryWidget extends PostItemRender<PetCategory> {
  PetCategoryWidget(PetCategory item) : super(item);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 15,
      color: TColors.water_melon,
    );
  }
}
