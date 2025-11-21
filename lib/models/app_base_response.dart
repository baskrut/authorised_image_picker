class AppBaseResponse<T extends Object?> {
  final String? errorText;
  final String? body;
  final bool? isSuccess;
  final T? result;

  AppBaseResponse({
    this.errorText,
    this.body,
    this.isSuccess,
    this.result,
  });

  @override
  String toString() {
    return 'AppBaseResponse{errorText: $errorText,  '
        'body: $body, isSuccess: $isSuccess, result: $result}';
  }
}
