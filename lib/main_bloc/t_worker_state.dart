part of petisland.main_bloc;

abstract class WorkerState extends BaseState {}

class UploadPostSuccess extends WorkerState {
  final Post item;

  UploadPostSuccess(this.item);
}

class UploadFailedState extends BaseErrorState implements WorkerState {
  UploadFailedState(String message) : super(message);
}
