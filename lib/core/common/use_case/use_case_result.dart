sealed class UseCaseResult<T> {
  const UseCaseResult();
}

class SuccessUseCaseResult<T> extends UseCaseResult<T> {
  const SuccessUseCaseResult({required this.data});

  final T data;
}

class FailureUseCaseResult<T> extends UseCaseResult<T> {
  const FailureUseCaseResult({
    this.error,
    this.message,
  });

  final Object? error;
  final String? message;
}
