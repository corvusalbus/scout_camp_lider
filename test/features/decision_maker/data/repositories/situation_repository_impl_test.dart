import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scout_camp_lider/features/decision_maker/data/datasources/situation_local_data_source.dart';
import 'package:scout_camp_lider/features/decision_maker/data/repositories/situation_repository_impl.dart';

class MockLocalDataSource extends Mock implements SituationLocalDataSource {}

void main() {
  MockLocalDataSource mockLocalDataSource = MockLocalDataSource();
  SituationRepositoryImpl repository =
      SituationRepositoryImpl(localDataSource: mockLocalDataSource);

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = SituationRepositoryImpl(localDataSource: mockLocalDataSource);
  });
}
