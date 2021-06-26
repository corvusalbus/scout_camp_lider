import 'package:scout_camp_lider/core/usecases/usecases.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/repositories/situation_repository.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/usecases/get_next_situation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSituationRepository extends Mock implements SituationRepository {
  @override
  Future<Situation> getNextSituation({int? currentSituation}) async =>
      super.noSuchMethod(
        Invocation.getter(#getNextSituation),
        returnValue: Situation(
            description: '',
            option1: '',
            option2: '',
            consequencesOfOption1: [0, 0, 0, 0],
            consequencesOfOption2: [0, 0, 0, 0]),
      );
}

void main() {
  MockSituationRepository mockSituationRepository = MockSituationRepository();
  GetNextSituation usecase = GetNextSituation(mockSituationRepository);

  setUp(() {
    mockSituationRepository = new MockSituationRepository();
    usecase = new GetNextSituation(mockSituationRepository);
  });
  final int tCurrentSituation = 0;
  final tSituation = Situation(
      description: 'Choose camp location',
      option1: 'In forest',
      option2: 'Near the lake',
      consequencesOfOption1: [1, 2, -3, 4],
      consequencesOfOption2: [5, -6, 0, 11]);
  test('should get Situation from repository', () async {
    //"On the fly" implementation of the Repository using the Mockito package.
    // When getNextSituation is called, always answer with
    when(mockSituationRepository.getNextSituation(
            currentSituation: tCurrentSituation))
        .thenAnswer((_) async => tSituation);

    final result = await usecase(Params(currentSituation: tCurrentSituation));

    expect(result, tSituation);

    verify(mockSituationRepository.getNextSituation(
        currentSituation: tCurrentSituation));

    verifyNoMoreInteractions(mockSituationRepository);
  });
}
