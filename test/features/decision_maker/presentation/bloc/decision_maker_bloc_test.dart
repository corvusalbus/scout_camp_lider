import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scout_camp_lider/core/error/exteption.dart';
import 'package:scout_camp_lider/core/usecases/usecases.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/usecases/get_first_situation.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/usecases/get_next_situation.dart';
import 'package:scout_camp_lider/features/decision_maker/presentation/bloc/decision_maker_bloc.dart';

class MockGetFirstSituation extends Mock implements GetFirstSituation {
  @override
  Future<Situation> call(NonParams nonParams) async => super.noSuchMethod(
        Invocation.getter(#call),
        returnValue: Situation(
            description: '',
            option1: '',
            option2: '',
            consequencesOfOption1: [0, 0, 0, 0],
            consequencesOfOption2: [0, 0, 0, 0]),
      );
}

class MockGetNextSituation extends Mock implements GetNextSituation {
  @override
  Future<Situation> call(Params params) async => super.noSuchMethod(
        Invocation.getter(#call),
        returnValue: Situation(
            description: '',
            option1: '',
            option2: '',
            consequencesOfOption1: [0, 0, 0, 0],
            consequencesOfOption2: [0, 0, 0, 0]),
      );
}

void main() {
  MockGetFirstSituation mockGetFirstSituation = MockGetFirstSituation();
  MockGetNextSituation mockGetNextSituation = MockGetNextSituation();

  DecisionMakerBloc decisionMakerBloc = DecisionMakerBloc(
      getFirstSituation: mockGetFirstSituation,
      getNextSituation: mockGetNextSituation);

  setUp(() {
    mockGetFirstSituation = MockGetFirstSituation();
    mockGetNextSituation = MockGetNextSituation();
    decisionMakerBloc = decisionMakerBloc = DecisionMakerBloc(
        getFirstSituation: mockGetFirstSituation,
        getNextSituation: mockGetNextSituation);
  });

  test('initial state schould be DecisionMakerInitial', () {
    expect(decisionMakerBloc.state, DecisionMakerInitial());
  });

  group('GetNextSituatuion', () {
    final int tOption = 1;
    final tSituation = Situation(
        description:
            "4 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.",
        option1: "Option 1 Suspendisse imperdiet sapien quis mi scelerisque",
        option2: "Option 2 Mauris interdum viverra lacinia.",
        consequencesOfOption1: [0, -4, 2, 1],
        consequencesOfOption2: [10, 2, 3, -4]);

    test('schould get data from usecase ', () async {
      final int tActualSituation = 4;

      when(mockGetNextSituation(Params(currentSituation: tActualSituation)))
          .thenAnswer((_) async => tSituation);

      decisionMakerBloc.add(OptionChosened(tActualSituation, tOption));
      await untilCalled(
          mockGetNextSituation(Params(currentSituation: tActualSituation)));

      verify(mockGetNextSituation(Params(currentSituation: tActualSituation)));
    });

    test(
        'schould emit [SituationLoadInProgress,SituationLoadSuccess] when data is gotten succesfully after Option1Chesened',
        () {
      final int tActualSituation = 4;

      when(mockGetNextSituation(Params(currentSituation: tActualSituation)))
          .thenAnswer((_) async => tSituation);

      final expected = [
        SituationLoadInProgress(),
        SituationLoadSuccess(situation: tSituation)
      ];

      expectLater(decisionMakerBloc.stream, emitsInOrder(expected));

      decisionMakerBloc.add(OptionChosened(tActualSituation, tOption));
    });

    test('schould emit [Error] when can not load data after Option1Chesened',
        () {
      final int tActualSituation = 4;

      when(mockGetNextSituation(Params(currentSituation: tActualSituation)))
          .thenThrow(FileException(message: 'Test File exception'));

      final expected = [
        SituationLoadInProgress(),
        Error('Test File exception')
      ];

      expectLater(decisionMakerBloc.stream, emitsInOrder(expected));

      decisionMakerBloc.add(OptionChosened(tActualSituation, tOption));
    });
  });

  group('GetFirstSituation', () {
    final tSituation = Situation(
        description:
            "4 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.",
        option1: "Option 1 Suspendisse imperdiet sapien quis mi scelerisque",
        option2: "Option 2 Mauris interdum viverra lacinia.",
        consequencesOfOption1: [0, -4, 2, 1],
        consequencesOfOption2: [10, 2, 3, -4]);

    test(
        'schould get data from usecase by mockGetFirstSituation when actual situation is 0 ',
        () async {
      when(mockGetFirstSituation(NonParams()))
          .thenAnswer((_) async => tSituation);

      decisionMakerBloc.add(GameStarted());
      await untilCalled(mockGetFirstSituation(NonParams()));

      verify(mockGetFirstSituation(NonParams()));
    });

    test(
        'schould emit [SituationLoadInProgress,SituationLoadSuccess] when data is gotten succesfully ater game started',
        () {
      when(mockGetFirstSituation(NonParams()))
          .thenAnswer((_) async => tSituation);

      final expected = [
        SituationLoadInProgress(),
        SituationLoadSuccess(situation: tSituation)
      ];

      expectLater(decisionMakerBloc.stream, emitsInOrder(expected));

      decisionMakerBloc.add(GameStarted());
    });

    test('schould emit [Error] when can not load data after game started', () {
      when(mockGetFirstSituation(NonParams()))
          .thenThrow(FileException(message: 'Test File exception'));

      final expected = [
        SituationLoadInProgress(),
        Error('Test File exception')
      ];

      expectLater(decisionMakerBloc.stream, emitsInOrder(expected));

      decisionMakerBloc.add(GameStarted());
    });
  });
}
