part of petisland.post.screen.widget;

class ImageSliderWidget extends StatelessWidget {
  final List<String> images;
  final String description;

  const ImageSliderWidget({Key key, @required this.images, @required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = buildTextDescription(context, description);
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        title,
        SizedBox(height: 5),
        Expanded(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemCount: images.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              final url = images[index];
              return PostImageWidget(imageUrl: url);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 15);
            },
          ),
        )
      ],
    );
  }
}

Widget buildTextDescription(BuildContext context, String text) {
  final theme = Theme.of(context);
  return DefaultTextStyle(
    style: TTextStyles.semi(
      letterSpacing: 0.3,
      fontSize: 16,
      color: theme.accentColor.withAlpha(128),
    ),
    child: Text(text),
  );
}
