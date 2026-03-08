import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/journal_entity.dart';

abstract class JournalRepository {
  Future<Either<Failure, List<JournalEntity>>> getAllEntries();
  Future<Either<Failure, Unit>> saveEntry(JournalEntity entry);
  Future<Either<Failure, Unit>> deleteEntry(int index);
}