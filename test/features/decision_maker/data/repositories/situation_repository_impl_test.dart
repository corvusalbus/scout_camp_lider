import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scout_camp_lider/core/error/exteption.dart';
import 'package:scout_camp_lider/features/decision_maker/data/datasources/situation_local_data_source.dart';
import 'package:scout_camp_lider/features/decision_maker/data/models/situatuation_model.dart';
import 'package:scout_camp_lider/features/decision_maker/data/repositories/situation_repository_impl.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';

class MockLocalDataSource extends Mock implements SituationLocalDataSource {
  @override
  Future<SituationModel> getNextSituation({int? currentSituation}) async =>
      super.noSuchMethod(
        Invocation.getter(#getNextSituation),
        returnValue: SituationModel(
            description: '',
            option1: '',
            option2: '',
            consequencesOfOption1: [0, 0, 0, 0],
            consequencesOfOption2: [0, 0, 0, 0]),
      );
  @override
  Future<SituationModel> getFirstSituation() async => super.noSuchMethod(
        Invocation.getter(#getFirstSituation),
        returnValue: SituationModel(
            description: '',
            option1: '',
            option2: '',
            consequencesOfOption1: [0, 0, 0, 0],
            consequencesOfOption2: [0, 0, 0, 0]),
      );
}

void main() {
  MockLocalDataSource mockLocalDataSource = MockLocalDataSource();
  SituationRepositoryImpl repository =
      SituationRepositoryImpl(localDataSource: mockLocalDataSource);

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = SituationRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('getNextSituation', () {
    final tCurrentSituation = 1;
    final tSituationModel = SituationModel(
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.',
        option1: 'Option 1 Suspendisse imperdiet sapien quis mi scelerisque',
        option2: 'Option 2 Mauris interdum viverra lacinia.',
        consequencesOfOption1: [0, -4, 2, 1],
        consequencesOfOption2: [10, 2, 3, -4]);
    final Situation tSituation = tSituationModel;
    test('schould return local data situation when call', () async {
      when(mockLocalDataSource.getNextSituation(
              currentSituation: tCurrentSituation))
          .thenAnswer((_) async => tSituationModel);

      final result = await repository.getNextSituation(
          currentSituation: tCurrentSituation);

      verify(mockLocalDataSource.getNextSituation(
          currentSituation: tCurrentSituation));

      expect(result, tSituation);
    });

    test('schould throw FileException when file is unavabile', () async {
      when(mockLocalDataSource.getNextSituation(
              currentSituation: tCurrentSituation))
          .thenThrow(FileException(message: 'TestExceptions'));

      await expectLater(
          repository.getNextSituation(currentSituation: tCurrentSituation),
          throwsA(isA<FileException>()));

      verify(mockLocalDataSource.getNextSituation(
          currentSituation: tCurrentSituation));
    });
  });

  group('getFirstSituation', () {
    final tCurrentSituation = 1;
    final tSituationModel = SituationModel(
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.',
        option1: 'Option 1 Suspendisse imperdiet sapien quis mi scelerisque',
        option2: 'Option 2 Mauris interdum viverra lacinia.',
        consequencesOfOption1: [0, -4, 2, 1],
        consequencesOfOption2: [10, 2, 3, -4]);
    final Situation tSituation = tSituationModel;

    test('schould return local first situation when call', () async {
      when(mockLocalDataSource.getFirstSituation())
          .thenAnswer((_) async => tSituationModel);
      final result = await repository.getFirstSituation();

      verify(mockLocalDataSource.getFirstSituation());
      expect(result, tSituation);
    });

    test('schould throw FileException when is some problem with file',
        () async {
      when(mockLocalDataSource.getFirstSituation())
          .thenThrow(FileException(message: 'TestExceptions'));

      await expectLater(
          repository.getFirstSituation(), throwsA(isA<FileException>()));
      verify(mockLocalDataSource.getFirstSituation());
    });
  });
}
