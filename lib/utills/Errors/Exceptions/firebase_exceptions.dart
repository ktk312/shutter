class EFirebaseException implements Exception {
  final String code;
  EFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'firebase-error':
        return 'A Firebase error occurred. Please try again later.';
      case 'firebase-timeout':
        return 'Firebase request timed out. Please try again.';
      case 'firebase-unavailable':
        return 'Firebase service is currently unavailable. Please try again later.';
      case 'firebase-internal-error':
        return 'An internal Firebase error occurred. Please try again later.';
      case 'firebase-api-unavailable':
        return 'The Firebase API is currently unavailable. Please try again later.';
      case 'firebase-permission-denied':
        return 'Permission denied by Firebase. Please check your permissions.';
      case 'firebase-quota-exceeded':
        return 'Firebase quota exceeded. Please try again later.';
      case 'firebase-database-error':
        return 'A Firebase Database error occurred. Please try again later.';
      case 'firebase-authentication-error':
        return 'A Firebase Authentication error occurred. Please try again later.';
      case 'firebase-storage-error':
        return 'A Firebase Storage error occurred. Please try again later.';
      case 'firebase-firestore-error':
        return 'A Firebase Firestore error occurred. Please try again later.';
      case 'firebase-messaging-error':
        return 'A Firebase Messaging error occurred. Please try again later.';
      case 'firebase-functions-error':
        return 'A Firebase Functions error occurred. Please try again later.';
      case 'firebase-crashlytics-error':
        return 'A Firebase Crashlytics error occurred. Please try again later.';
      case 'firebase-performance-error':
        return 'A Firebase Performance error occurred. Please try again later.';
      default:
        return 'An unknown Firebase error occurred.';
    }
  }
}
