part of petisland.main_bloc;

class TWorker extends TBloc<WorkerEvent, WorkerState> {
  static final ImageService uploadService = DI.get<ImageService>(ImageService);
  static final PostService postService = DI.get<PostService>(PostService);

  @override
  Duration get delayEvent => const Duration(milliseconds: 50);

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
      case UploadImageEvent:
        _uploadImage(event);
        break;
      case UploadPostEvent:
        _uploadPost(event);
        break;
      case LikePostEvent:
        _likePost(event);
        break;
      case UploadPostSuccessEvent:
        yield UploadPostSuccess();
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
      final PostModal postMustUpload = event.postModal..images.addAll(images);
      add(UploadPostEvent._(postMustUpload: postMustUpload));
    }

    final List<String> paths = event.imagesMustUpload;
    uploadService
        .upload(paths)
        .then(_uploadPostModal)
        .catchError(_handleError)
        .catchError((_) => add(UploadFailedEvent('Upload failed')));
  }

  void _uploadPost(UploadPostEvent event) {
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

  void _likePost(LikePostEvent event) {
    postService.like(event.id).catchError((_) => Log.error(_));
  }

  void uploadPost(PostModal modal, List<String> images) {
    if (images?.isNotEmpty == true) {
      add(UploadImageEvent._(postModal: modal, imagesMustUpload: images));
    } else {
      add(UploadPostEvent._(postMustUpload: modal));
    }
  }

  void likePost(String id) {
    add(LikePostEvent(id));
  }
}
