part of petisland.post.post_edit.screen;

/// Post edit will be create mode when Post is null
class PostEditScreen extends TStatelessWidget {
  static const String name = '/PostEditScreen';
  final Post post;
  final void Function(PostModal post, List<String> images) onSendTap;
  final PostEditBloc _postEditBloc = PostEditBloc();

  PostEditScreen.create({@required this.onSendTap}) : post = null;

  PostEditScreen.edit(this.post, {@required this.onSendTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng Tin'),
        centerTitle: true,
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) => SendWidget(
              onPressSend: () => _onPressSend(context),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          PostEditBody(_postEditBloc, post: this.post),
        ],
      ),
    );
  }

  void _onPressSend(BuildContext context) {
    final PostModal postModal = PostModal.create(
        title: _postEditBloc.title,
        description: _postEditBloc.description,
        location: _postEditBloc.location,
        price: _postEditBloc.price,
        pet: Pet(type: _postEditBloc.petCategory),
        tags: _postEditBloc.tags);

    if (!postModal.titleIsValid) {
      showErrorSnackBar(context: context, content: 'Vui lòng nhập tiêu đề');
      return;
    }
    if (!postModal.locationIsValid) {
      showErrorSnackBar(context: context, content: 'Vui lòng nhập Vui lòng nhập địa chỉ');
      return;
    }

    if (onSendTap != null) {
      onSendTap(postModal, _postEditBloc.imagesLocalPath);
    }
  }
}
