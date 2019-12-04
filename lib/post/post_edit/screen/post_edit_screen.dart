part of petisland.post.post_edit.screen;

/// Post edit will be create mode when Post is null
class PostEditScreen extends StatelessWidget {
  ///Will be change String to Post
  final String post;
  final void Function(PostModal post) onSendTap;
  final PostEditBloc _postEditBloc = DI.get(PostEditBloc);

  PostEditScreen.create({@required this.onSendTap}) : post = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Đăng Tin"),
        centerTitle: true,
        actions: <Widget>[
          SendWidget(
            onPressSend: _onPressSend,
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          PostEditBody(),
        ],
      ),
    );
  }

  void _onPressSend() {
    final PostModal postModal = PostModal.create(
        title: _postEditBloc.title,
        location: null,
        price: _postEditBloc.price,
        pet: null);
    if (onSendTap != null) {
      onSendTap(postModal);
    }
  }
}
