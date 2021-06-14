import 'package:scout_camp_lider/features/decision_maker/domain/repositories/situation_repository.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';
import 'package:scout_camp_lider/core/usecases/usecases.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/usecases/get_first_situation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSituationRepository extends Mock implements SituationRepository {
  @override
  Future<Situation> getFirstSituation() async => super.noSuchMethod(
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
  GetFirstSituation usecase = GetFirstSituation(mockSituationRepository);

  setUp(() {
    mockSituationRepository = new MockSituationRepository();
    usecase = new GetFirstSituation(mockSituationRepository);
  });

  final tSituation = Situation(
      description: 'Choose camp location',
      option1: 'In forest',
      option2: 'Near the lake',
      consequencesOfOption1: [1, 2, -3, 4],
      consequencesOfOption2: [5, -6, 0, 11]);
  test('should get first Situation from repository', () async {
    //"On the fly" implementation of the Repository using the Mockito package.
    // When getNextSituation is called, always answer with
    when(mockSituationRepository.getFirstSituation())
        .thenAnswer((_) async => tSituation);

    final result = await usecase(NonParams());

    expect(result, tSituation);

    verify(mockSituationRepository.getFirstSituation());

    verifyNoMoreInteractions(mockSituationRepository);
  });
}
