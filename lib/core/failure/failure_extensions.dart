import 'failure.dart';

extension FailureExtensions on Failure {
  bool get isNetworkError =>
      this is NetworkFailure ||
      this is ConnectionFailure ||
      this is TimeoutFailure;
  
  bool get isAuthError =>
      this is AuthFailure ||
      this is InvalidCredentialsFailure ||
      this is EmailAlreadyInUseFailure ||
      this is UserNotFoundFailure;
  
  bool get isPermissionError =>
      this is PermissionFailure ||
      this is UnauthorizedFailure;
  
  bool get shouldRetry {
    if (this is ConnectionFailure || this is TimeoutFailure) {
      return true;
    }
    
    if (this is ServerFailure) {
      final serverFailure = this as ServerFailure;
      // Retry on 5xx errors, not on 4xx
      return serverFailure.statusCode != null &&
          serverFailure.statusCode! >= 500 &&
          serverFailure.statusCode! < 600;
    }
    
    return false;
  }
  
  String get userFriendlyMessage {
    if (this is ConnectionFailure) {
      return 'Please check your internet connection and try again.';
    }
    
    if (this is TimeoutFailure) {
      return 'The request took too long. Please try again.';
    }
    
    if (this is InvalidCredentialsFailure) {
      return 'Invalid email or password. Please try again.';
    }
    
    if (this is EmailAlreadyInUseFailure) {
      return 'This email is already registered. Please use a different email or sign in.';
    }
    
    if (this is UserNotFoundFailure) {
      return 'Account not found. Please check your email or sign up.';
    }
    
    if (this is UnauthorizedFailure) {
      return 'You don\'t have permission to access this resource.';
    }
    
    if (this is NotFoundFailure) {
      return 'The requested resource was not found.';
    }
    
    // Default message
    return message;
  }
}