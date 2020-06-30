part of petisland.rescue_voting.widget;

class HeroVotingListingWidget extends StatefulWidget {
  final String rescueId;

  HeroVotingListingWidget({Key key, @required this.rescueId}) : super(key: key);

  @override
  _HeroVotingListingWidgetState createState() => _HeroVotingListingWidgetState();
}

class _HeroVotingListingWidgetState extends State<HeroVotingListingWidget> {
  HeroVotingBloc bloc;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    bloc = HeroVotingBloc(widget.rescueId)..loadHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<HeroVotingBloc, HeroVotingState>(
          bloc: bloc,
          listener: (context, state) => setState(() => isLoading = false),
          listenWhen: (previous, current) =>
              isLoading == true && current is ReloadHeroVotingListing,
          buildWhen: (_, state) => state is ReloadHeroVotingListing,
          builder: (_, state) {
            final spacer = const SizedBox(height: 10);
            return ListView.separated(
              shrinkWrap: true,
              primary: true,
              itemCount: bloc.heroes.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return VoteHeroWidget(
                  heroVotingInfo: bloc.heroes[index],
                  onVoteHero: _handleVoteHero,
                );
              },
              separatorBuilder: (context, index) => spacer,
            );
          },
        ),
        isLoading ? LoadingWidget() : SizedBox(),
      ],
    );
  }

  void _handleVoteHero(HeroVotingInfo votingInfo) {
    setState(() {
      isLoading = true;
    });
    bloc.vote(votingInfo.hero.id);
  }
}
