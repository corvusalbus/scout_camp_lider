import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'decision_maker_event.dart';
part 'decision_maker_state.dart';
class DecisionMakerBloc extends Bloc<DecisionMakerEvent, DecisionMakerState> {
  DecisionMakerBloc() : super(DecisionMakerInitial());
  @override
  Stream<DecisionMakerState> mapEventToState(
    DecisionMakerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
