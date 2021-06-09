import '../../../../core/usecases/usecases.dart';
import '../entities/situation.dart';
import '../repositories/situation_repository.dart';

class GetFirstSituation implements UseCase<Situation, Params> {
  final SituationRepository repository;

  GetFirstSituation(this.repository);

  Future<Situation> call(Params params) async =>
      await repository.getFirstSituation();
}
