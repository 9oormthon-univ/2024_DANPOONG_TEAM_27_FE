sealed class RepositoryResult<T> {
  const RepositoryResult();
}

class SuccessRepositoryResult<T> extends RepositoryResult<T> {
  const SuccessRepositoryResult({required this.data});

  final T data;
}

class FailureRepositoryResult<T> extends RepositoryResult<T> {
  const FailureRepositoryResult({
    this.error,
    this.messages,
  });

  final Object? error;
  final List<String>? messages;
}
