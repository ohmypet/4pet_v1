part of petisland.pet_feed.widget.post_panel;

class _PostPanelDescriptionWidget extends StatelessWidget {
  final Post item;

  const _PostPanelDescriptionWidget({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleWidget = _buildTitleWidget(context, item.title);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          colors: [
            TColors.black.withOpacity(0.10),
            TColors.black.withOpacity(0.2),
          ],
          stops: [0.5, 0.75],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(child: titleWidget),
            Flexible(
              child: Theme(
                child: PostButtonLikeWidget(item: item),
                data: theme.copyWith(
                  textTheme: theme.textTheme.copyWith(
                    display4: theme.textTheme.display4.copyWith(
                      color: TColors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitleWidget(BuildContext context, String title) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: 16,
        fontFamily: FontFamilies.sarabun,
        color: TColors.white,
        fontWeight: FontWeight.w800,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      child: Text(title),
    );
  }
}
