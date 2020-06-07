part of petisland.rescue_post.widget;

class RescueCreationDetailWidget extends TStatefulWidget {
  final RescueEditingBloc rescueEditingBloc;

  RescueCreationDetailWidget(this.rescueEditingBloc, {Key key}) : super(key: key);

  @override
  _RescueCreationDetailWidgetState createState() => _RescueCreationDetailWidgetState();
}

class _RescueCreationDetailWidgetState extends TState<RescueCreationDetailWidget> {
  RescueEditingBloc get editingBloc => widget.rescueEditingBloc;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        BlocBuilder<RescueEditingBloc, RescueEditingState>(
          bloc: editingBloc,
          condition: (_, state) => state is DataChanged,
          builder: (BuildContext context, RescueEditingState state) {
            return SummaryInfoWidget(
              editingBloc.rescue.title,
              price: editingBloc.rescue.totalCoin,
              location: editingBloc.rescue.location,
              petImage: editingBloc.rescue.images.map((e) => e.url).toList(),
              maxHeros: editingBloc.rescue.maxHeroes,
            );
          },
        )
      ],
    );
  }
}
