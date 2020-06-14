part of petisland.pet_feed.widget.rescue;

class PreviewRescueDefaultWidget extends StatelessWidget {
  const PreviewRescueDefaultWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75, // 3/4
      child: Stack(
        children: <Widget>[
          TShimmerLoading(),
          Container(
            margin: const EdgeInsets.all(4),
            alignment: Alignment.topRight,
            child: CircleColorWidget(
              child: SizedBox(
                width: 24,
                height: 24,
                child: TShimmerLoading.circle(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
