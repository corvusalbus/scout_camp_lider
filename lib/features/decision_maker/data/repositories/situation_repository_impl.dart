import 'package:scout_camp_lider/features/decision_maker/data/datasources/situation_local_data_source.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/repositories/situation_repository.dart';

class SituationRepositoryImpl implements SituationRepository {
  final SituationLocalDataSource localDataSource;

  SituationRepositoryImpl({required this.localDataSource});

  @override
  Future<Situation> getFirstSituation() async {
    return localDataSource.getFirstSituation();
  }

  @override
  Future<Situation> getNextSituation({int? currentSituation}) async {
    return localDataSource.getNextSituation(currentSituation: currentSituation);
  }
}
