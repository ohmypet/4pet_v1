part of petisland.rescue_post.widget;

class HeroListingWidget extends StatelessWidget {
  final RescueHeroBloc heroBloc;
  final String maxHeroeAsString;

  const HeroListingWidget({
    Key key,
    @required this.heroBloc,
    @required this.maxHeroeAsString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              buildTextDescription(context, 'Heroes($maxHeroeAsString)'),
              const SizedBox(height: 2),
              Flexible(child: AccountListView(accounts: heroBloc.heroes)),
            ],
          );
        } else
          return const SizedBox();
      },
    );
  }
}
