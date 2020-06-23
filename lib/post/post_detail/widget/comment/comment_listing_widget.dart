part of petisland.post.screen.widget;

class CommentListingWidget extends StatefulWidget {
  final CommentBloc bloc;
  final ValueChanged<String> onDeleteComment;
  const CommentListingWidget({Key key, @required this.bloc, this.onDeleteComment})
      : super(key: key);

  @override
  _CommentListingWidgetState createState() => _CommentListingWidgetState();
}

class _CommentListingWidgetState extends State<CommentListingWidget> {
  CommentBloc get bloc => widget.bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      bloc: bloc,
      condition: (_, state) => state is ReloadUIState,
      builder: _buildCommentUI,
    );
  }

  Widget _buildCommentUI(BuildContext context, CommentState state) {
    if (state is ReloadUIState) {
      final items = state.items;
      final divider = const Divider();
      return Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          items.isNotEmpty ? buildTextDescription(context, 'Comment') : const SizedBox(),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: items.length + 1,
            itemBuilder: (_, __) => _buildComment(_, __, items),
            separatorBuilder: (_, int index) {
              return divider;
            },
          ),
        ],
      );
    } else {
      final random = DI.get<Random>(Random);
      return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: random.nextInt(15) + 7,
        itemBuilder: (_, __) => _CommentLoadingWidget(),
        separatorBuilder: (_, int index) {
          return Divider();
        },
      );
    }
  }

  Widget _buildComment(BuildContext context, int index, List<Comment> items) {
    if (index < items.length) {
      final item = items[index];
      return CommentWidget(item: item, onTapDelete: () => _onTapDelete(index, item));
    } else
      return SizedBox(height: 150);
  }

  void _onTapDelete(int index, Comment comment) {
    if (widget.onDeleteComment != null) {
      widget.onDeleteComment(comment.id);
    }
    bloc.softDeleteComment(comment.id);
  }
}
