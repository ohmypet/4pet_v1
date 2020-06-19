part of petisland.rescue_post.widget;

class AccountSponsorshipWidget extends StatelessWidget {
  final List<RescueDonate> rescueDonates;

  const AccountSponsorshipWidget({
    Key key,
    @required this.rescueDonates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: rescueDonates.length,
        itemBuilder: _itemBuildAccountSponsorship,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }

  Widget _itemBuildAccountSponsorship(BuildContext context, int index) {
    return DonationInfoWidget(rescueDonate: rescueDonates[index]);
  }
}

class DonationInfoWidget extends StatelessWidget {
  final RescueDonate rescueDonate;

  const DonationInfoWidget({
    Key key,
    @required this.rescueDonate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: TConstants.border_all,
          color: TColors.white,
          boxShadow: TShadows.innerShadow2,
          border: Border.all(
            color: TColors.water_melon,
            style: BorderStyle.solid,
            width: 0.4,
          )
        ),
        padding: const EdgeInsets.all(5),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(child: UserInfoWidget(account: rescueDonate.account), flex: 3),
            Flexible(child: _buildDonationInfo(), flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationInfo() {
    final coin = rescueDonate.coin ?? 0;
    return Container(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: coin.toString(),
            style: TTextStyles.bold(color: TColors.water_melon_light),
          ),
          TextSpan(
            text: ' coin',
            style: TTextStyles.medium(color: TColors.brown_grey),
          ),
        ]),
      ),
    );
  }
}
