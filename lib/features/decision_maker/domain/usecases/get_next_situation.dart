import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scout_camp_lider/core/usecases/usecases.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';
import '../repositories/situation_repository.dart';

import '../entities/situation.dart';

class GetNextSituation implements UseCase<Situation, Params> {
  final SituationRepository repository;

  GetNextSituation(this.repository);

  Future<Situation> call(Params params) async {
    return await repository.getNextSituation(
        currentSituation: params.currentSituation);
  }
}

class Params extends Equatable {
  final int currentSituation;
  Params({required this.currentSituation}) : super();

  @override
  List<Object?> get props => [currentSituation];
}
