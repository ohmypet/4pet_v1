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

  final List<String> numberHeros = ['Unlimited volunteer'];
  final titleEdittingController = TextEditingController();
  final descriptionEdittingController = TextEditingController();
  final rewardEdittingController = TextEditingController();

  bool get isEditMode => editingBloc.mode == RescueMode.Edit;
  final double maxCoin = 12;

  void initState() {
    super.initState();
    for (int i = 1; i < 10; ++i) {
      numberHeros.add('$i volunteer');
    }
    if (isEditMode) {
      titleEdittingController.text = editingBloc.rescue.title ?? '';
      descriptionEdittingController.text = editingBloc.rescue.description ?? '';
      rewardEdittingController.text = editingBloc.rescue.totalCoin?.toString() ?? '0';
    }

    titleEdittingController.addListener(() {
      editingBloc.rescue.title = titleEdittingController.text;
      editingBloc.notifyChangedValue();
    });
    descriptionEdittingController.addListener(() {
      editingBloc.rescue.description = descriptionEdittingController.text;
    });
    rewardEdittingController.addListener(_handleRewardChanged);
  }

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
      condition: (_, state) => state is ReloadSummaryState,
      builder: (BuildContext context, RescueEditingState state) {
        return SummaryInfoWidget(
          editingBloc.rescue.title,
          money: editingBloc.rescue.totalCoin,
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
      editingController: titleEdittingController,
    );
  }

  Widget _buildInputDesciption() {
    return TitleInputWidget(
      title: 'Description',
      hintText: 'Description about rescue',
      isRequired: false,
      maxLines: 1,
      editingController: descriptionEdittingController,
    );
  }

  Widget _buildReward() {
    return EnableWidget(
      enable: !isEditMode,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: TitleInputWidget(
                title: 'Reward',
                subTitle: ' (maximun ${maxCoin.toInt()} coin)',
                hintText: '0',
                keyboardType: TextInputType.number,
                editingController: rewardEdittingController,
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
      ),
    );
  }

  Widget _buildLocation() {
    return DropdownInputWidget<String>(
      onFind: _handleOnFind,
      title: 'Location',
      isRequired: true,
      hintText: 'Ho Chi Minh City, Vietnam',
      selectedItem: editingBloc.rescue.location,
      onSelected: (text) => editingBloc.rescue.location = text,
    );
  }

  Widget _buildVolunteer() {
    return DropDownInputWidget(
      title: 'Volunteer',
      initSelectedItem: editingBloc.rescue.maxHeroes,
      data: numberHeros,
      onSelectedChanged: (heroes) => editingBloc.rescue.maxHeroes = heroes,
    );
  }

  Widget _buildImages() {
    return BlocBuilder<RescueEditingBloc, RescueEditingState>(
      bloc: editingBloc,
      condition: (_, state) => state is ReloadImageSlider,
      builder: (_, state) {
        return ImageInputWidget(
          images: [
            ...editingBloc.oldImages,
            ...editingBloc.newImages,
          ],
          onAddImage: _handleAddImage,
        );
      },
    );
  }

  void _onTapMaximun() {
    rewardEdittingController.text = maxCoin.toString();
  }

  Future<List<String>> _handleOnFind(String text) {
    final googleService = DI.get<LocationService>(LocationService);
    return googleService.getSuggestionLocation(text).then((resp) {
      if (resp.predictions.isNotEmpty) {
        return resp.predictions.map((location) => location.description).toList();
      } else {
        return [text];
      }
    }).catchError((ex) => [text]);
  }

  void _handleAddImage(String value) {
    editingBloc.newImages.add(value);
    editingBloc.loadImages();
  }

  void dispose() {
    super.dispose();
    this.descriptionEdittingController.dispose();
    this.titleEdittingController.dispose();
    this.rewardEdittingController.dispose();
  }

  bool _canPaid(num coin, num maxCoin) => coin <= maxCoin;

  void _handleRewardChanged() {
    final coin = double.tryParse(rewardEdittingController.text);
    if (coin != null) {
      if (_canPaid(coin, maxCoin)) {
        editingBloc.rescue.totalCoin = coin;
        editingBloc.notifyChangedValue();
      } else {
        rewardEdittingController.text = maxCoin.toInt().toString();
      }
    } else {
      rewardEdittingController.text = '0';
    }
  }
}
