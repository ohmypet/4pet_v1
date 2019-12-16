part of petisland.main_bloc;

abstract class WorkerEvent extends BaseEvent {}

class UploadImageEvent extends WorkerEvent {
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

class UploadPostEvent extends WorkerEvent {
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

class UploadPostSuccessEvent extends WorkerEvent {}

class UploadFailedEvent extends BaseErrorEvent implements WorkerEvent {
  UploadFailedEvent(String message) : super(message);
}

class LikePostEvent extends WorkerEvent {
  final String id;

  LikePostEvent(this.id);
}
