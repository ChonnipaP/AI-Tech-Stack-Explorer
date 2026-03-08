// lib/core/error/failures.dart
import 'package:equatable/equatable.dart';

// Base class — ทุก error ต้อง extend อันนี้
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// แต่ละประเภท error
class NetworkFailure  extends Failure {
  const NetworkFailure(super.message);
}

class LocalDbFailure  extends Failure {
  const LocalDbFailure(super.message);
}

class MLKitFailure    extends Failure {
  const MLKitFailure(super.message);
}

class CacheFailure    extends Failure {
  const CacheFailure(super.message);
}

class ServerFailure   extends Failure {
  const ServerFailure(super.message);
}