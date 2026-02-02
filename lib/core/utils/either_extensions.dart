import 'package:fpdart/fpdart.dart';
import '../failure/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = Future<Either<Failure, void>>;

extension FutureEitherExtensions<T> on FutureEither<T> {
  Future<T> foldOrThrow({
    T Function(Failure failure)? onFailure,
    void Function(Failure failure)? onFailureSideEffect,
  }) async {
    final either = await this; // 👈 await the Future<Either>

    return either.fold(
      (failure) {
        onFailureSideEffect?.call(failure);
        if (onFailure != null) {
          return onFailure(failure);
        }
        throw failure;
      },
      (success) => success,
    );
  }
}


// Helper for try-catch pattern with Either
Either<Failure, T> tryCatch<T>(
  T Function() tryBlock, {
  Failure Function(Object error, StackTrace stackTrace)? onError,
}) {
  try {
    return Right(tryBlock());
  } catch (error, stackTrace) {
    if (onError != null) {
      return Left(onError(error, stackTrace));
    }
    
    // Default error handling
    if (error is Failure) {
      return Left(error);
    }
    
    return Left(UnknownFailure(
      message: error.toString(),
      stackTrace: stackTrace,
    ));
  }
}

FutureEither<T> tryCatchAsync<T>(
  Future<T> Function() tryBlock, {
  Failure Function(Object error, StackTrace stackTrace)? onError,
}) async {
  try {
    final result = await tryBlock();
    return Right(result);
  } catch (error, stackTrace) {
    if (onError != null) {
      return Left(onError(error, stackTrace));
    }
    
    if (error is Failure) {
      return Left(error);
    }
    
    return Left(UnknownFailure(
      message: error.toString(),
      stackTrace: stackTrace,
    ));
  }
}