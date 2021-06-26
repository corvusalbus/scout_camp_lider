import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scout_camp_lider/core/error/exteption.dart';
import 'package:scout_camp_lider/core/usecases/usecases.dart';

import '../../domain/entities/situation.dart';
import '../../domain/usecases/get_first_situation.dart';
import '../../domain/usecases/get_next_situation.dart';

part 'decision_maker_event.dart';
part 'decision_maker_state.dart';

class DecisionMakerBloc extends Bloc<DecisionMakerEvent, DecisionMakerState> {
  final GetFirstSituation getFirstSituation;
  final GetNextSituation getNextSituation;

  DecisionMakerBloc(
      {required this.getFirstSituation, required this.getNextSituation})
      : super(DecisionMakerInitial());

  // @override
  // DecisionMakerState get initialState => DecisionMakerInitial();

  @override
  Stream<DecisionMakerState> mapEventToState(
    DecisionMakerEvent event,
  ) async* {
    if (event is OptionChosened) {
      yield* getSituation(
        event,
        Params(currentSituation: event.actualSituation),
        getNextSituation,
      );
    } else if (event is GameStarted) {
      yield* getSituation(event, NonParams(), getFirstSituation);
    }
    // if (event is OptionChosened) {
    //   yield SituationLoadInProgress();
    //   try {
    //     final situation = await getNextSituation(
    //         Params(currentSituation: event.actualSituation));
    //     yield SituationLoadSuccess(situation: situation);
    //   } on FileException catch (e) {
    //     yield Error(e.message);
    //   } catch (e) {
    //     yield Error(e.toString());
    //   }
    // } else if (event is GameStarted) {
    //   yield SituationLoadInProgress();
    //   try {
    //     final situation = await getFirstSituation(NonParams());
    //     yield SituationLoadSuccess(situation: situation);
    //   } on FileException catch (e) {
    //     yield Error(e.message);
    //   } catch (e) {
    //     yield Error(e.toString());
    //   }
    // }
  }

  Stream<DecisionMakerState> getSituation(
      DecisionMakerEvent event, preParams params, UseCase useCase) async* {
    yield SituationLoadInProgress();
    try {
      final situation = await useCase(params);
      yield SituationLoadSuccess(situation: situation);
    } on FileException catch (e) {
      yield Error(e.message);
    } catch (e) {
      yield Error(e.toString());
    }
  }
}
