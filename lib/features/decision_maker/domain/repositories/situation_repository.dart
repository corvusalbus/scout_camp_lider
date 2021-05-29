import 'package:dartz/dartz.dart';
import 'package:scout_camp_lider/core/error/failure.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';

abstract class SituationRepository {
  Future<Either<Failure, Situation>> getNextSituation();
}
