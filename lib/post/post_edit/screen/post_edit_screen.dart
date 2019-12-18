part of petisland.post.post_edit.screen;

/// Post edit will be create mode when Post is null
class PostEditScreen extends TStatelessWidget {
  static const String name = '/PostEditScreen';
  final void Function(PostModal post, List<String> images) onSendTap;
  final PostEditBloc _postEditBloc;

  PostEditScreen.create({@required this.onSendTap}) : _postEditBloc = PostEditBloc();

  PostEditScreen.edit(Post post, {@required this.onSendTap}) : _postEditBloc = PostEditBloc.fromPost(post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng Tin'),
        centerTitle: true,
        actions: <Widget>[
          Builder(
            builder: (context) => SendWidget(
              onPressSend: () => _onPressSend(context),
            ),
          )
        ],
      ),
      body: PostEditBody(_postEditBloc),
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
