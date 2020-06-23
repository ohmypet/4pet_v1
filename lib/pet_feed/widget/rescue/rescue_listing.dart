part of petisland.pet_feed.widget.rescue;

class RescueListing extends TStatefulWidget {
  final ValueChanged<String> onTapRescuePost;

  const RescueListing({this.onTapRescuePost, Key key}) : super(key: key);

  @override
  TState<RescueListing> createState() => _RescueListingState();
}

class _RescueListingState extends TState<RescueListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: GestureDetector(
        onTap: _handleOnTapClick,
        child: Container(
          color: TColors.red,
        ),
      ),
    );
  }

  void _handleOnTapClick() {
    if (widget.onTapRescuePost != null) {
      widget.onTapRescuePost(ThinId.randomId());
    }
  }
}
