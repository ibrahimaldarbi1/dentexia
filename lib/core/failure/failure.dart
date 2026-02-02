import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final StackTrace? stackTrace;
  
  const Failure({
    required this.message,
    this.stackTrace,
  });
  
  @override
  List<Object?> get props => [message, stackTrace];
  
  @override
  String toString() => 'Failure(message: $message, stackTrace: $stackTrace)';
}

// Network failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Network error occurred',
    super.stackTrace,
  });
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({
    super.message = 'No internet connection',
    super.stackTrace,
  });
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Request timed out',
    super.stackTrace,
  });
}

// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Authentication failed',
    super.stackTrace,
  });
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure({
    super.message = 'Invalid email or password',
    super.stackTrace,
  });
}

class EmailAlreadyInUseFailure extends Failure {
  const EmailAlreadyInUseFailure({
    super.message = 'Email already in use',
    super.stackTrace,
  });
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure({
    super.message = 'Password is too weak',
    super.stackTrace,
  });
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure({
    super.message = 'User not found',
    super.stackTrace,
  });
}

// Database failures
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    super.message = 'Database error occurred',
    super.stackTrace,
  });
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Resource not found',
    super.stackTrace,
  });
}

class DataParsingFailure extends Failure {
  const DataParsingFailure({
    super.message = 'Failed to parse data',
    super.stackTrace,
  });
}

// Permission failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    super.message = 'Permission denied',
    super.stackTrace,
  });
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Unauthorized access',
    super.stackTrace,
  });
}

// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Validation failed',
    super.stackTrace,
  });
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({
    super.message = 'Invalid input',
    super.stackTrace,
  });
}

// Platform-specific failures
class PlatformFailure extends Failure {
  const PlatformFailure({
    super.message = 'Platform error',
    super.stackTrace,
  });
}

// Unknown/catch-all failure
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unknown error occurred',
    super.stackTrace,
  });
}

// Cache failures
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Cache error',
    super.stackTrace,
  });
}

class NoDataFailure extends Failure {
  const NoDataFailure({
    super.message = 'No data available',
    super.stackTrace,
  });
}

// Server failures
class ServerFailure extends Failure {
  final int? statusCode;
  
  const ServerFailure({
    super.message = 'Server error',
    super.stackTrace,
    this.statusCode,
  });
  
  @override
  List<Object?> get props => [...super.props, statusCode];
}

// File system failures
class FileSystemFailure extends Failure {
  const FileSystemFailure({
    super.message = 'File system error',
    super.stackTrace,
  });
}

class FileNotFoundFailure extends Failure {
  const FileNotFoundFailure({
    super.message = 'File not found',
    super.stackTrace,
  });
}

// Feature-specific failures
class AppointmentFailure extends Failure {
  const AppointmentFailure({
    super.message = 'Appointment error',
    super.stackTrace,
  });
}

class PaymentFailure extends Failure {
  const PaymentFailure({
    super.message = 'Payment failed',
    super.stackTrace,
  });
}