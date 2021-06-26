import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecases.dart';
import '../entities/situation.dart';
import '../repositories/situation_repository.dart';

class GetNextSituation implements UseCase<Situation, Params> {
  final SituationRepository repository;

  GetNextSituation(this.repository);

  Future<Situation> call(Params params) async {
    return await repository.getNextSituation(
        currentSituation: params.currentSituation);
  }
}
