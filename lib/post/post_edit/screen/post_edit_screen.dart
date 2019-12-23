part of petisland.post.post_edit.screen;

typedef OnCreatePostScreen = void Function(PostCreateModal post, List<String> urlNeedUpload);

typedef OnEditPostScreen = void Function(
  PostCreateModal post,
  List<PostImage> rawPostImage,
  List<String> urlNeedUpload,
  List<String> idImageNeedDelete,
);

class PostEditScreen extends TStatelessWidget {
  static const String name = '/PostEditScreen';
  final OnCreatePostScreen onSendTap;
  final OnEditPostScreen onEditCompleted;
  final PostEditBloc _postEditBloc;

  PostEditScreen.create({@required this.onSendTap})
      : _postEditBloc = PostEditBloc(),
        onEditCompleted = null;

  PostEditScreen.edit(Post post, {@required this.onEditCompleted})
      : _postEditBloc = PostEditBloc.fromPost(post),
        this.onSendTap = null;

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
    final PostCreateModal postModal = PostCreateModal.create(
      title: _postEditBloc.title,
      description: _postEditBloc.description,
      location: _postEditBloc.location,
      price: _postEditBloc.price,
      pet: Pet(type: _postEditBloc.petCategory),
      tags: _postEditBloc.tags,
    );

    if (!postModal.titleIsValid) {
      showErrorSnackBar(context: context, content: 'Vui lòng nhập tiêu đề');
      return;
    }
    if (!postModal.locationIsValid) {
      showErrorSnackBar(context: context, content: 'Vui lòng nhập Vui lòng nhập địa chỉ');
      return;
    }

    final localPaths = _getPathImagesNeedUpload(_postEditBloc.postImages);
    Navigator.of(context).pop();

    if (onSendTap != null) {
      onSendTap(postModal, localPaths);
    }
    if (onEditCompleted != null) {
      final ids = _getIdImagesNeedDelete(_postEditBloc.imagesRemoved);
      onEditCompleted(postModal, _postEditBloc.postImages, localPaths, ids);
    }
  }

  List<String> _getPathImagesNeedUpload(List<PostImage> images) {
    return images.where((item) => item.id == null).map((item) => item.image.url).toList();
  }

  List<String> _getIdImagesNeedDelete(List<PostImage> images) {
    return images.map((item) => item.id).toList();
  }
}
