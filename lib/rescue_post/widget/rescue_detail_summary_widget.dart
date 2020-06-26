part of petisland.rescue_post.widget;

class RescueDetailSummaryWidget extends StatelessWidget {
  final Rescue rescue;
  final bool hideDescription;
  final bool hideLocation;
  final bool hideImageSlider;

  const RescueDetailSummaryWidget({
    Key key,
    @required this.rescue,
    this.hideDescription,
    this.hideLocation,
    this.hideImageSlider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.vertical,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: PreviewRescueDetailWidget(rescue: rescue),
              ),
              Expanded(
                flex: 1,
                child: RescueActionBar(rescue: rescue),
              )
            ],
          ),
        ),
        hideDescription == true || rescue.description.isEmpty
            ? const SizedBox()
            : _buildDescriptions(description: rescue.description, context: context),
        hideLocation == true ? const SizedBox() : _buildLocation(context),
        const SizedBox(height: 5),
        hideImageSlider == true
            ? const SizedBox()
            : Flexible(child: _buildImageSlider(rescue.rescueImages)),
      ],
    );
  }

  Widget _buildImageSlider(List<RescueImage> postImages) {
    return postImages?.isNotEmpty == true
        ? Container(
            height: 105,
            child: ImageSliderWidget(
              images: rescue.rescueImages.map((e) => e.image.url).toSet().toList(),
              description: 'Images',
            ),
          )
        : SizedBox();
  }

  Widget _buildDescriptions({@required BuildContext context, String description}) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        buildTextDescription(context, 'Description'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: PostDescriptionWidget(description: description),
        ),
      ],
    );
  }

  Widget _buildLocation(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        buildTextDescription(context, 'Location'),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: PostDescriptionWidget(description: rescue.location ?? ''),
        ),
      ],
    );
  }
}
