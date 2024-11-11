class EGeneralException implements Exception {
  final String code;
  EGeneralException(this.code);

  String get message {
    switch (code) {
      case 'network-request-failed':
        return 'Network request failed. Please check your connection.';
      case 'timeout':
        return 'Request timed out. Please try again.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'permission-denied':
        return 'You do not have permission to perform this operation.';
      case 'resource-exhausted':
        return 'Resource exhausted. Please try again later.';
      case 'unauthenticated':
        return 'Unauthenticated request. Please log in and try again.';
      case 'invalid-argument':
        return 'Invalid argument provided. Please check your input.';
      case 'not-found':
        return 'The requested resource was not found.';
      case 'already-exists':
        return 'The resource already exists. Please use a different identifier.';
      case 'failed-precondition':
        return 'Failed precondition. Please check the requirements.';
      case 'aborted':
        return 'The operation was aborted. Please try again.';
      case 'out-of-range':
        return 'The operation was out of range. Please check the limits.';
      case 'unavailable':
        return 'The service is currently unavailable. Please try again later.';
      case 'data-loss':
        return 'Data loss occurred. Please contact support.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      default:
        return 'An unknown error occurred.';
    }
  }
}
