part of petisland.rescue_voting.widget;

class VoteHeroWidget extends StatelessWidget {
  final HeroVotingInfo heroVotingInfo;
  final ValueChanged<HeroVotingInfo> onVoteHero;

  const VoteHeroWidget({Key key, @required this.heroVotingInfo, this.onVoteHero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: TColors.water_melon_light,
        ),
        color: TColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: TShadows.innerShadow2,
      ),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildAvatar(),
          Expanded(child: _buildTitle(context, heroVotingInfo.hero), flex: 3),
          Expanded(child: _buildVoting()),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      margin: const EdgeInsets.all(7),
      child: AspectRatio(
        aspectRatio: 1,
        child: CircleColorWidget(
          padding: const EdgeInsets.all(2),
          child: AvatarWidget(
            url: heroVotingInfo.hero?.user?.avatar?.url,
            paddingDefaultImage: const EdgeInsets.all(2),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Account account) {
    final name = account.getName();
    final ThemeData theme = Theme.of(context);

    return name != null
        ? Text(
            name,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w500),
          )
        : SizedBox();
  }

  Widget _buildVoting() {
    final primaryColor =
        heroVotingInfo.isVoted == true ? TColors.water_melon_light : TColors.brown_grey;

    return GestureDetector(
      onTap: _onPressVote,
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Typicons.thumbs_up,
            color: primaryColor,
          ),
          Flexible(
            child: Text(
              heroVotingInfo.voteAsString,
              style: TTextStyles.semi(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _onPressVote() {
    if (onVoteHero != null) {
      onVoteHero(heroVotingInfo);
    }
  }
}
