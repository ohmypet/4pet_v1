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
        description: _postEditBloc.description,
        location: _postEditBloc.location,
        price: _postEditBloc.price,
        pet: Pet(type: PetCategory(id: "35d15307-7136-45d5-bfb2-8e63bdc1e108"))
        // pet: _postEditBloc.chungLoai,
        // tags: _postEditBloc.
        );
    DI.get<WorkerUpload>(WorkerUpload).uploadPost(postModal, _postEditBloc.imagesLocalPath);
    // if (onSendTap != null) {
    //   onSendTap(postModal);
    // }
  }
}
