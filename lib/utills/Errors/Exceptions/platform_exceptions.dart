class EPlatformException implements Exception {
  final String code;
  EPlatformException(this.code);

  String get message {
    switch (code) {
      case 'platform-unavailable':
        return 'This platform is currently unavailable. Please try again later.';
      case 'platform-error':
        return 'An error occurred on this platform. Please contact support.';
      case 'operation-failed':
        return 'The operation failed on this platform. Please try again.';
      case 'not-implemented':
        return 'This feature is not implemented on this platform.';
      case 'incompatible-version':
        return 'The platform version is incompatible with this feature.';
      case 'platform-initialization-failed':
        return 'Platform initialization failed. Please restart the application.';
      case 'missing-platform-dependency':
        return 'A required platform dependency is missing. Please check your installation.';
      case 'platform-configuration-error':
        return 'There is a configuration error on this platform. Please review your settings.';
      case 'hardware-incompatibility':
        return 'The platform hardware is incompatible with this operation.';
      case 'software-incompatibility':
        return 'The platform software is incompatible with this operation.';
      case 'driver-error':
        return 'A platform driver error occurred. Please update your drivers.';
      case 'platform-api-unavailable':
        return 'The platform API is currently unavailable. Please try again later.';
      case 'permission-denied':
        return 'Permission denied on this platform. Please grant the necessary permissions.';
      case 'storage-full':
        return 'The platform storage is full. Please free up some space.';
      case 'platform-timeout':
        return 'The platform operation timed out. Please try again.';
      default:
        return 'An unknown platform error occurred.';
    }
  }
}
