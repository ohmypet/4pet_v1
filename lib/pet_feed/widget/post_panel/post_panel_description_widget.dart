part of petisland.pet_feed.widget.post_panel;

class PostPanelDescriptionWidget extends StatefulWidget {
  final Post item;

  const PostPanelDescriptionWidget({Key key, @required this.item}) : super(key: key);

  @override
  _PostPanelDescriptionWidgetState createState() => _PostPanelDescriptionWidgetState();
}

class _PostPanelDescriptionWidgetState extends State<PostPanelDescriptionWidget> {
  bool isLock = false;
  TWorker get worker => DI.get(TWorker);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleWidget = _buildTitleWidget(context, widget.item.title);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: TGradients.defaultGradient,
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
                child: PostButtonLikeWidget(
                  isReacted: widget.item.isReacted,
                  likes: widget.item.getLikes(),
                  onTapLike: _handleOnTapLike,
                ),
                data: theme.copyWith(
                  textTheme: theme.textTheme.copyWith(
                    headline1: theme.textTheme.headline1.copyWith(
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

  void _handleOnTapLike() {
    if (isLock) return;
    isLock = true;
    worker.likePost(widget.item.id);
    setState(() {
      if (widget.item.isReacted) {
        widget.item.unLike();
      } else {
        widget.item.like();
      }
    });
    Future.delayed(const Duration(milliseconds: 600)).whenComplete(() {
      isLock = false;
    });
  }
}
