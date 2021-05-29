import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';

import '../repositories/situation_repository.dart';
import '../../../../core/error/failure.dart';
import '../entities/situation.dart';

class GetNextSituation {
  final SituationRepository repository;

  GetNextSituation(this.repository);

  Future<Either<Failure, Situation>> call() async {
    return await repository.getNextSituation();
  }
}
