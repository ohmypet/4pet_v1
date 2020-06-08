part of petisland.rescue_post.widget;

class RescueCreationDetailWidget extends TStatefulWidget {
  final RescueEditingBloc rescueEditingBloc;

  RescueCreationDetailWidget(this.rescueEditingBloc, {Key key}) : super(key: key);

  @override
  _RescueCreationDetailWidgetState createState() => _RescueCreationDetailWidgetState();
}

class _RescueCreationDetailWidgetState extends TState<RescueCreationDetailWidget> {
  RescueEditingBloc get editingBloc => widget.rescueEditingBloc;
  final String defaultTitle = 'Can you help my kitten ...';
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        _buildSummaryRescuePost(),
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 5),
              _buildInputTitle(),
              _buildInputDesciption(),
              _buildReward(),
              _buildLocation(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRescuePost() {
    return BlocBuilder<RescueEditingBloc, RescueEditingState>(
      bloc: editingBloc,
      condition: (_, state) => state is DataChanged,
      builder: (BuildContext context, RescueEditingState state) {
        return SummaryInfoWidget(
          editingBloc.rescue.title,
          price: editingBloc.rescue.totalCoin,
          location: editingBloc.rescue.location,
          petImage: editingBloc.rescue.images.map((e) => e.url).toList(),
          maxHeros: editingBloc.rescue.maxHeroes,
          customDefaultMoney: 'Charity',
          typeMoney: 'coin',
          customDefaultTitle: defaultTitle,
        );
      },
    );
  }

  Widget _buildInputTitle() {
    return TitleInputWidget(
      title: 'Title',
      hintText: defaultTitle,
      isRequired: true,
    );
  }

  Widget _buildInputDesciption() {
    return TitleInputWidget(
      title: 'Description',
      hintText: 'Description about rescue',
      isRequired: false,
      maxLines: 1,
    );
  }

  Widget _buildReward() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: TitleInputWidget(
            title: 'Reward',
            subTitle: ' (maximun 12 coin)',
            hintText: '0',
          ),
        ),
        Container(
          width: 55,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: PetIslandButtonWidget(
            text: 'Max',
            onTap: _onTapMaximun,
          ),
        )
      ],
    );
  }

  Widget _buildLocation() {
    return TitleInputWidget(
      title: 'Location',
      isRequired: true,
      hintText: 'Ho Chi Minh, Viet Nam',
    );
  }

  void _onTapMaximun() {}
}
