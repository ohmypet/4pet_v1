part of petisland.rescue_post.widget;

class RescueDetailSummaryWidget extends StatelessWidget {
  final Rescue rescue;
  final RescueHeroBloc heroBloc;
  final RescueDonateBloc donateBloc;

  const RescueDetailSummaryWidget({
    Key key,
    @required this.rescue,
    @required this.heroBloc,
    @required this.donateBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageSliderWidget = _buildImageSlider(rescue.rescueImages);
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
        ...(rescue.description.isNotEmpty
            ? _buildDescriptions(description: rescue.description, context: context)
            : [SizedBox()]),
        _buildLocation(context),
        const SizedBox(height: 5),
        Flexible(child: imageSliderWidget),
        const SizedBox(height: 5),
        _buildHero(context),
        const SizedBox(height: 5),
        _buildDonator(context),
      ],
    );
  }

  Widget _buildImageSlider(List<RescueImage> postImages) {
    return postImages?.isNotEmpty == true
        ? Container(
            height: 150,
            child: ImageSliderWidget(
              images: rescue.rescueImages.map((e) => e.image.url).toSet().toList(),
              description: 'Images',
            ),
          )
        : SizedBox();
  }

  List<Widget> _buildDescriptions({@required BuildContext context, String description}) {
    return [
      const SizedBox(height: 15),
      buildTextDescription(context, 'Description'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: PostDescriptionWidget(description: description),
      ),
    ];
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

  Widget _buildHero(BuildContext context) {
    return BlocBuilder<RescueHeroBloc, RescueHeroState>(
      bloc: heroBloc,
      condition: (_, state) => state is ReloadListingState,
      builder: (_, state) {
        if (heroBloc.heroes.isNotEmpty) {
          return Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              buildTextDescription(context, 'Heroes'),
              const SizedBox(height: 2),
              Flexible(child: AccountListView(accounts: heroBloc.heroes)),
            ],
          );
        } else
          return const SizedBox();
      },
    );
  }

  Widget _buildDonator(BuildContext context) {
    return BlocBuilder<RescueDonateBloc, RescueHeroState>(
      bloc: donateBloc,
      condition: (_, state) => state is ReloadListingState,
      builder: (_, state) {
        if (donateBloc.rescueDonates.isNotEmpty) {
          return Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              PanelDescriptionBar(
                title: 'Sponsorships',
                customSubTitle: 'Donate',
                customStringIcon: ' <<',
                onTapSubTitle: _handleDonate,
              ),
              const SizedBox(height: 5),
              Flexible(child: AccountSponsorshipWidget(rescueDonates: donateBloc.rescueDonates))
            ],
          );
        } else
          return const SizedBox();
      },
    );
  }

  void _handleDonate() {}
}
