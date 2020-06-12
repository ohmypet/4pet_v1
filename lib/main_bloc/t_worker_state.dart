part of petisland.main_bloc;

abstract class WorkerState extends BaseState {}

class UploadPostSuccess extends WorkerState {
  final Post post;
  final String message;

  UploadPostSuccess(this.post, {this.message = ''});
}

class UploadFailedState extends BaseErrorState implements WorkerState {
  UploadFailedState(String message) : super(message);
}
