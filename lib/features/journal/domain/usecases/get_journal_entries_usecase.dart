import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/journal_entity.dart';
import '../repositories/journal_repository.dart';

class GetJournalEntriesUseCase {
  final JournalRepository _repo;
  GetJournalEntriesUseCase(this._repo);

  Future<Either<Failure, List<JournalEntity>>> call() {
    return _repo.getAllEntries();
  }
}