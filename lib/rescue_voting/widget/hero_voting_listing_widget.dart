part of petisland.rescue_voting.widget;

class HeroVotingListingWidget extends StatefulWidget {
  final String rescueId;
  final HeroVotingBloc bloc;

  HeroVotingListingWidget({Key key, @required this.rescueId})
      : bloc = HeroVotingBloc(rescueId),
        super(key: key);

  @override
  _HeroVotingListingWidgetState createState() => _HeroVotingListingWidgetState();
}

class _HeroVotingListingWidgetState extends State<HeroVotingListingWidget> {
  HeroVotingBloc get bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
    bloc.loadHeroes();
  }

  @override
  Widget build(BuildContext context) {
    final spacer = const SizedBox(height: 5);
    return BlocBuilder<HeroVotingBloc, HeroVotingState>(
      bloc: bloc,
      condition: (_, state) => state is ReloadHeroVotingListing,
      builder: (_, state) {
        if (widget.bloc.heroes.isNotEmpty) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: bloc.heroes.length,
            itemBuilder: (context, index) => Container(
              color: TColors.green,
              height: 25,
              width: 23,
            ),
            separatorBuilder: (context, index) => spacer,
          );
        } else
          return const SizedBox();
      },
    );
  }
}
