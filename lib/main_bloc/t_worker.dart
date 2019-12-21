part of petisland.main_bloc;

class TWorker extends TBloc<WorkerEvent, WorkerState> {
  static final ImageService uploadService = DI.get<ImageService>(ImageService);
  static final PostService postService = DI.get<PostService>(PostService);
  static final ReportService reportService = DI.get(ReportService);

  @override
  Duration get delayEvent => PetIslandConstants.time_delay_retry;

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
      case UploadPostSuccessEvent:
        yield UploadPostSuccess();
        break;
      default:
        if (event is UploadImageEvent) _uploadImage(event);
        break;
    }
  }

  @override
  WorkerState get initialState => UploadPostSuccess();

  void _uploadImage(UploadImageEvent event) {
    void _handleError(dynamic ex) {
      Log.error(ex);
      final UploadImageEvent newEventUpload = event.retry();
      Log.debug('Retry ${newEventUpload.numRetry}');
      add(newEventUpload);
    }

    void _uploadPostModal(List<PetImage> images) {
      if (event.postModal is PostCreateModal) {
        final PostCreateModal postMustUpload = event.postModal..newsImages.addAll(images);
        add(UploadPostEvent._(postMustUpload: postMustUpload));
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

  void _createPost(UploadPostEvent event) {
    void _retryUpload(dynamic ex) {
      Log.error(ex);
      final UploadPostEvent newUpload = event.retry();
      Log.debug('Retry ${newUpload.numRetry}');
      add(newUpload);
    }

    postService
        .create(event.postMustUpload)
        .then((_) => add(UploadPostSuccessEvent()))
        .catchError(_retryUpload)
        .catchError((_) => add(UploadFailedEvent('Upload failed')));
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
        .then((_) => add(UploadPostSuccessEvent()))
        .catchError(_retryUpload)
        .catchError((_) => add(UploadFailedEvent('Upload failed')));
  }

  void _deletePost(DeletePostEvent event) {
    postService
        .delete(event.postId)
        .then((_) => Log.info('Delete success post ${event.postId}'))
        .catchError((_) => Log.error('Error delete post: $_'));
  }

  void _likePost(LikePostEvent event) {
    postService.like(event.id).catchError((_) => Log.error(_));
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

  void createPost(PostCreateModal modal, List<String> images) {
    if (images?.isNotEmpty == true) {
      add(UploadImageEvent._(postModal: modal, imagesMustUpload: images));
    } else {
      add(UploadPostEvent._(postMustUpload: modal));
    }
  }

  void updatePost(Post post, List<String> urlNeedUpload, List<String> idImageNeedDelete) {
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
        imagesMustUpload: urlNeedUpload,
        postModal: postEditModal,
      );
      add(event);
    } else {
      add(UpdatePostEvent._(postMustUpdate: postEditModal));
    }
  }

  void likePost(String id) {
    add(LikePostEvent(id));
  }

  void report(String postId, String reason, String accountId, {String description}) {
    add(ReportPostEvent(reason, postId, accountId, description: description));
  }

  void deletePost(String postId) {
    add(DeletePostEvent(postId));
  }
}
