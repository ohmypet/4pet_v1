part of petisland.main_bloc;

class WorkerUpload extends TBloc<UploadEvent, UploadState> {
  static final ImageService uploadService = DI.get<ImageService>(ImageService);
  static final PostService postService = DI.get<PostService>(PostService);

  @override
  Duration get delayEvent => const Duration(milliseconds: 50);

  @override
  Stream<UploadState> errorToState(BaseErrorEvent event) async* {
    switch (event.runtimeType) {
      case UploadFailedEvent:
        yield UploadFailedState(event.message);
        break;
      default:
    }
  }

  @override
  Stream<UploadState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case UploadImageEvent:
        _uploadImage(event);
        break;
      case UploadPostEvent:
        _uploadPost(event);
        break;
      case UploadPostSuccessEvent:
        yield UploadPostSuccess();
        break;
    }
  }

  @override
  UploadState get initialState => UploadPostSuccess();

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

  void uploadPost(PostModal modal, List<String> images) {
    if (images?.isNotEmpty == true) {
      add(UploadImageEvent._(postModal: modal, imagesMustUpload: images));
    } else {
      add(UploadPostEvent._(postMustUpload: modal));
    }
  }
}

abstract class UploadEvent extends BaseEvent {}

abstract class UploadState extends BaseState {}

class UploadImageEvent extends UploadEvent {
  final int numRetry;
  final List<String> imagesMustUpload;
  final PostModal postModal;

  UploadImageEvent._({
    @required this.imagesMustUpload,
    @required this.postModal,
    this.numRetry = 0,
  });

  UploadImageEvent retry() {
    if (numRetry < PetIslandConstants.max_retry) {
      return UploadImageEvent._(
        numRetry: numRetry + 1,
        imagesMustUpload: imagesMustUpload,
        postModal: postModal,
      );
    } else
      throw LimitRetryException();
  }
}

class UploadPostEvent extends UploadEvent {
  final int numRetry;
  final PostModal postMustUpload;

  UploadPostEvent._({@required this.postMustUpload, this.numRetry = 0});

  UploadPostEvent retry() {
    if (numRetry < PetIslandConstants.max_retry) {
      return UploadPostEvent._(
        numRetry: numRetry + 1,
        postMustUpload: postMustUpload,
      );
    } else
      throw LimitRetryException();
  }
}

class UploadPostSuccessEvent extends UploadEvent {}

class UploadPostSuccess extends UploadState {}

class UploadFailedEvent extends BaseErrorEvent implements UploadEvent {
  UploadFailedEvent(String message) : super(message);
}

class UploadFailedState extends BaseErrorState implements UploadState {
  UploadFailedState(String message) : super(message);
}
