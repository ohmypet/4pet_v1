part of petisland.main_bloc;

class TWorker extends TBloc<WorkerEvent, WorkerState> {
  static final ImageService uploadService = DI.get<ImageService>(ImageService);
  static final PostService postService = DI.get<PostService>(PostService);
  static final ReportService reportService = DI.get(ReportService);
  static final RescueService rescueService = DI.get(RescueService);
  final mapCallBack = <String, VoidCallback>{};

  @override
  Duration get delayEvent => PetIslandConstants.time_delay_retry;

  @override
  WorkerState get initialState => UploadPostSuccess(null);

  void commentPost(String postId, String message) {
    add(CommentPostEvent(postId, message));
  }

  void createPost(PostCreateModal modal, List<String> images,
      {VoidCallback onCompleted}) {
    final id = ThinId.randomId();
    if (images?.isNotEmpty == true) {
      add(UploadImageEvent._(id: id, postModal: modal, imagesMustUpload: images));
    } else {
      add(UploadPostEvent._(id: id, postMustUpload: modal));
    }
    if (onCompleted != null) {
      mapCallBack.putIfAbsent(id, () => onCompleted);
    }
  }

  void deleteComment(String postId, String commentId) {
    if (commentId != null) add(DeleteCommentPostEvent(postId, commentId));
  }

  void deletePost(String postId) {
    add(DeletePostEvent(postId));
  }

  @override
  Stream<WorkerState> errorToState(BaseErrorEvent event) async* {
    switch (event.runtimeType) {
      case UploadFailedEvent:
        yield UploadFailedState(event.message);
        break;
      default:
    }
  }

  @override
  Stream<WorkerState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case UploadPostEvent:
        _createPost(event);
        break;
      case LikePostEvent:
        _likePost(event);
        break;
      case ReportPostEvent:
        _reportPost(event);
        break;
      case UpdatePostEvent:
        _updatePost(event);
        break;
      case DeletePostEvent:
        _deletePost(event);
        break;
      case DeleteCommentPostEvent:
        _deleteCommentPost(event);
        break;
      case CommentPostEvent:
        _commentPost(event);
        break;
      case LikeRescuePostEvent:
        _likeRescuePost(event);
        break;
      case UploadPostSuccessEvent:
        final e = event as UploadPostSuccessEvent;
        yield UploadPostSuccess(e.post, message: e.message);
        break;

      default:
        if (event is UploadImageEvent) _uploadImage(event);
        break;
    }
  }

  void likePost(String id) {
    add(LikePostEvent(id));
  }

  void likeRescuePost(String id) {
    add(LikeRescuePostEvent(id));
  }

  void report(String postId, String reason, String accountId, {String description}) {
    add(ReportPostEvent(reason, postId, accountId, description: description));
  }

  void updatePost(Post post, List<String> urlNeedUpload, List<String> idImageNeedDelete) {
    final id = ThinId.randomId();
    final PostEditModal postEditModal = PostEditModal(
      post.id,
      description: post.description,
      idImagesDelete: idImageNeedDelete,
      location: post.location,
      pet: post.pet,
      price: post.price,
      settings: post.settings,
      title: post.title,
      status: post.status,
    );
    if (urlNeedUpload?.isNotEmpty == true) {
      final event = UploadImageEvent<PostEditModal>._(
        id: id,
        imagesMustUpload: urlNeedUpload,
        postModal: postEditModal,
      );
      add(event);
    } else {
      add(UpdatePostEvent._(postMustUpdate: postEditModal));
    }
  }

  void _commentPost(CommentPostEvent event) {
    postService
        .createComment(event.postId, event.message)
        .then((_) => Log.info('Comment Success'))
        .catchError((ex) => Log.error('Comment Failed: $ex'));
  }

  void _createPost(UploadPostEvent event) {
    void _retryUpload(ex, trace) {
      Log.error(trace);
      final UploadPostEvent newUpload = event.retry();
      Log.debug('Retry ${newUpload.numRetry}');
      add(newUpload);
    }

    postService
        .create(event.postMustUpload)
        .then((_) => add(UploadPostSuccessEvent(_, message: 'Create the post success')))
        .catchError(_retryUpload)
        .catchError((_) => add(UploadFailedEvent('Upload failed')));
  }

  void _deleteCommentPost(DeleteCommentPostEvent event) {
    Log.info('${event.postId} - ${event.commentId}');
    postService
        .deleteComment(event.postId, event.commentId)
        .then((_) => Log.info('Delete Comment Success'))
        .catchError((ex, t) => Log.error('Delete Comment Failed: $ex - $t'));
  }

  //---------------------------------------------
  void _deletePost(DeletePostEvent event) {
    postService
        .delete(event.postId)
        .then((_) => Log.info('Delete success post ${event.postId}'))
        .catchError((_) => Log.error('Error delete post: $_'));
  }

  void _likePost(LikePostEvent event) {
    postService.like(event.id).catchError((_) => Log.error(_));
  }

  void _likeRescuePost(LikeRescuePostEvent event) {
    rescueService.like(event.rescueId);
  }

  void _reportPost(ReportPostEvent event) {
    void retryUpload(dynamic ex) {
      Log.error('Fail upload:: $ex');
      Log.info('Retry upload ${event.runtimeType} ${event.numRetry} times');
      final newEvent = event.retry();
      add(newEvent);
    }

    reportService
        .report(event.postId, event.reason, event.accountId,
            description: event.description)
        .then((_) => Log.info('Upload success ${event.runtimeType}'))
        .catchError(retryUpload)
        .catchError((_) => Log.error('Failed upload report'));
  }

  void _updatePost(UpdatePostEvent event) {
    void _retryUpload(dynamic ex) {
      Log.error(ex);
      final UpdatePostEvent newUpload = event.retry();
      Log.debug('Retry ${newUpload.numRetry}');
      add(newUpload);
    }

    postService
        .edit(event.postMustUpdate)
        .then((_) => add(UploadPostSuccessEvent(_, message: 'Update the post success')))
        .catchError(_retryUpload)
        .catchError((_) => add(UploadFailedEvent('Upload failed')));
  }

  void _uploadImage(UploadImageEvent event) {
    void _handleError(dynamic ex) {
      Log.error(ex);
      final UploadImageEvent newEventUpload = event.retry();
      Log.debug('Retry ${newEventUpload.numRetry}');
      add(newEventUpload);
    }

    void _uploadPostModal(List<PetImage> images) {
      if (event.postModal is PostCreateModal) {
        final post = event.postModal as PostCreateModal;
        final PostCreateModal postMustUpload = post..images.addAll(images);
        add(UploadPostEvent._(id: ThinId.randomId(), postMustUpload: postMustUpload));
      } else {
        final PostEditModal postMustUpload = event.postModal;
        final idImages = images.map((item) => item.id).toList();
        postMustUpload.newsImages.addAll(idImages);
        add(UpdatePostEvent._(postMustUpdate: postMustUpload));
      }
    }

    final List<String> paths = event.imagesMustUpload;
    uploadService
        .upload(paths)
        .then(_uploadPostModal)
        .catchError(_handleError)
        .catchError((_) => add(UploadFailedEvent('Upload failed')));
  }
}
