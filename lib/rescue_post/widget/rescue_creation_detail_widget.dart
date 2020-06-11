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
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 5),
              _buildInputTitle(),
              _buildInputDesciption(),
              _buildReward(),
              _buildLocation(),
              _buildVolunteer(),
              _buildImages(),
              const SizedBox(height: 60),
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
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: TitleInputWidget(
              title: 'Reward',
              subTitle: ' (maximun 12 coin)',
              hintText: '0',
              keyboardType: TextInputType.number,
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
      ),
    );
  }

  Widget _buildLocation() {
    // return TitleInputWidget(
    //   title: 'Location',
    //   isRequired: true,
    //   hintText: 'Ho Chi Minh, Viet Nam',
    // );
    return DropdownInputWidget(
      onFind: handleOnFind,
      title: 'Location',
      isRequired: true,
      hintText: 'Ho Chi Minh City',
    );
  }

  Widget _buildVolunteer() {
    return DropDownInputWidget(
      title: 'Volunteer',
      data: [
        '1 person',
        '3 person',
        '5 person',
        '8 person',
        '10 person',
        'Unlimited volunteer'
      ],
    );
  }

  Widget _buildImages() {
    return ImageInputWidget(
      images: [
        'https://github.com/tvc12.png',
        'https://github.com/tvc12.png',
        'https://github.com/tvc12.png',
        'https://github.com/tvc12.png',
      ],
    );
  }

  void _onTapMaximun() {}

  Future<List<String>> handleOnFind(String text) {
    final googleService = DI.get<LocationService>(LocationService);
    return googleService.getSuggestionLocation(text).then(
        (resp) => resp.predictions.map((location) => location.description).toList());
  }
}
