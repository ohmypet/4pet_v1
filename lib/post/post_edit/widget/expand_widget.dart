part of petisland.post.post_edit.widget;

class ExpandWidget extends TStatelessWidget {
  final PostEditBloc bloc;

  ExpandWidget(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          bloc.expandChange();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.more_horiz,
            size: 44,
          ),
        ),
      ),
    );
  }
}
