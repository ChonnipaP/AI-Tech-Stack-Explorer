import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/journal_entity.dart';
import '../../domain/repositories/journal_repository.dart';
import '../datasources/journal_local_datasource.dart';

class JournalRepositoryImpl implements JournalRepository {
  final JournalLocalDataSource _local;
  JournalRepositoryImpl(this._local);

  @override
  Future<Either<Failure, List<JournalEntity>>> getAllEntries() async {
    try {
      final entries = await _local.getAllEntries();
      return Right(entries);
    } catch (e) {
      return Left(LocalDbFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveEntry(JournalEntity entry) async {
    try {
      await _local.saveEntry(entry);
      return const Right(unit);
    } catch (e) {
      return Left(LocalDbFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteEntry(int index) async {
    return const Right(unit);
  }
}