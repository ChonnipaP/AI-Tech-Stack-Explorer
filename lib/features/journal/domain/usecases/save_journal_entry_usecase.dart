import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/journal_entity.dart';
import '../repositories/journal_repository.dart';

class SaveJournalEntryUseCase {
  final JournalRepository _repo;
  SaveJournalEntryUseCase(this._repo);

  Future<Either<Failure, Unit>> call(JournalEntity entry) {
    return _repo.saveEntry(entry);
  }
}