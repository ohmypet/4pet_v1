part of petisland.post.screen.widget;

class CommnetListingWidget extends StatefulWidget {
  final Post item;

  const CommnetListingWidget({Key key, @required this.item}) : super(key: key);
  @override
  _CommnetListingWidgetState createState() => _CommnetListingWidgetState();
}

class _CommnetListingWidgetState extends State<CommnetListingWidget> {
  CommentBloc bloc;

  void initState() {
    super.initState();
    bloc = CommentBloc(widget.item.id)..reload();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTextDescription(context, 'Bình luận'),
        BlocBuilder<CommentBloc, CommentState>(
          bloc: bloc,
          condition: (_, state) => state is RealoadUIState,
          builder: _buildCommentUI,
        ),
      ],
    );
  }

  Widget _buildCommentUI(BuildContext context, CommentState state) {
    if (state is RealoadUIState) {
      final items = state.items;
      Log.info('_buildCommentUI:: ${items.length}');
      return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: items.length + 1,
        itemBuilder: (_, __) => _buildComment(_, __, items),
        separatorBuilder: (_, int index) {
          return Divider();
        },
      );
    } else {
      return SizedBox();
    }
  }

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  Widget _buildComment(BuildContext context, int index, List<Comment> items) {
    if (index < items.length) {
      final item = items[index];
      return _CommentWidget(item: item);
    } else
      return SizedBox(height: 150);
  }
}
