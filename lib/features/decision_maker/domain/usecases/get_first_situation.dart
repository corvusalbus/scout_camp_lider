import '../../../../core/usecases/usecases.dart';
import '../entities/situation.dart';
import '../repositories/situation_repository.dart';

class GetFirstSituation implements UseCase<Situation, NonParams> {
  final SituationRepository repository;

  GetFirstSituation(this.repository);

  Future<Situation> call(NonParams params) async =>
      await repository.getFirstSituation();
}
