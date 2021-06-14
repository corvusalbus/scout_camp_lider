import 'package:scout_camp_lider/features/decision_maker/data/models/situatuation_model.dart';

abstract class SituationLocalDataSource {
  ///Get next situations from situations.json
  ///
  ///Throws a [FileException] for all errors.
  Future<SituationModel> getNextSituation({int? currentSituation});

  ///Get a first situation from situations.json
  ///
  ///Throws a [FileException] for all errors.
  Future<SituationModel> getFirstSituation();
}
