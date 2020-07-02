part of petisland.rescue_post.widget;

class SponsorListingWidget extends StatelessWidget {
  final RescueDonateBloc donateBloc;

  const SponsorListingWidget({Key key, @required this.donateBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Divider(),
        _buildSponsors(context),
        Divider(),
      ],
    );
  }

  Widget _buildSponsors(BuildContext context) {
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
              Center(
                child: PanelDescriptionBar(
                  title: 'Sponsors',
                  customSubTitle: 'Donate',
                  customStringIcon: ' <<',
                  onTapSubTitle: _handleOnDonate,
                ),
              ),
              const SizedBox(height: 5),
              Flexible(
                  child:
                      AccountSponsorshipWidget(rescueDonates: donateBloc.rescueDonates))
            ],
          );
        } else
          return const SizedBox();
      },
    );
  }

  void _handleOnDonate() {
    // handle donate
  }
}
