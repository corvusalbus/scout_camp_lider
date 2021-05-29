import 'package:dartz/dartz.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/repositories/situation_repository.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/usecases/get_next_situation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSituationRepository extends Mock implements SituationRepository {}

void main() {
  MockSituationRepository mockSituationRepository = MockSituationRepository();
  GetNextSituation usecase = GetNextSituation(mockSituationRepository);

  setUp(() {
    mockSituationRepository = new MockSituationRepository();
    usecase = new GetNextSituation(mockSituationRepository);
  });

  final tSituation = Situation(
      description: 'Choose camp location',
      option1: 'In forest',
      option2: 'Near the lake',
      consequencesOfOption1: [1, 2, -3, 4],
      consequencesOfOption2: [5, -6, 0, 11]);
  test('should get Situation from repository', () async {
    //"On the fly" implementation of the Repository using the Mockito package.
    // When getNextSituation is called, always answer with
    // the Right "side" of Either containing a test Situation object
    when(mockSituationRepository.getNextSituation())
        .thenAnswer((_) async => Right(tSituation));

    final result = await usecase();

    expect(result, Right(tSituation));

    verify(mockSituationRepository.getNextSituation());

    verifyNoMoreInteractions(mockSituationRepository);
  });
}
