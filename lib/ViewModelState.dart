class ViewModelState<T> {
  Status status;
  T? data;
  String? message;

  ViewModelState.initial(this.message) : status = Status.initial;

  ViewModelState.loading(this.message) : status = Status.loading;

  ViewModelState.completed(this.data) : status = Status.completed;

  ViewModelState.error(this.message) : status = Status.error;

}

enum Status { initial, loading, completed, error }