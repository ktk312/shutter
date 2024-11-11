class EFirebaseAuthException implements Exception {
  final String code;
  EFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'invalid-credential':
        return 'The provided authentication credential is invalid.';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please try again.';
      case 're-authentication-required':
        return 'Re-authentication required. Please log in again.';
      case 'credential-already-in-use':
        return 'The credential is already associated with a different user account.';
      case 'invalid-phone-number':
        return 'The phone number is invalid. Please enter a valid phone number.';
      default:
        return 'An unknown authentication error occurred.';
    }
  }
}
