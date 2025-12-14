sealed class Result<T> {
  final T? data;
  final String? error;

  const Result({this.data, this.error});
}

final class Success<T> extends Result {
  const Success({required T super.data});
}

final class Failure extends Result {
  const Failure({required String super.error});
}
