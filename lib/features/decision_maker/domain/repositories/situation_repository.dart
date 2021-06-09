import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';

abstract class SituationRepository {
  Future<Situation> getNextSituation();
  Future<Situation> getFirstSituation();
}
