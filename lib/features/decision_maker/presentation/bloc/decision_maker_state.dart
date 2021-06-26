part of 'decision_maker_bloc.dart';

abstract class DecisionMakerState extends Equatable {
  const DecisionMakerState();
}

class DecisionMakerInitial extends DecisionMakerState {
  @override
  List<Object> get props => [];
}

class DecisionMakerGameOver extends DecisionMakerState {
  @override
  List<Object?> get props => [];
}

class SituationLoadInProgress extends DecisionMakerState {
  @override
  List<Object?> get props => [];
}

class SituationLoadSuccess extends DecisionMakerState {
  final Situation situation;

  SituationLoadSuccess({required this.situation});
  @override
  List<Object?> get props => [situation];
}

class SituationLoadFailure extends DecisionMakerState {
  @override
  List<Object?> get props => [];
}

class Error extends DecisionMakerState {
  final String message;

  Error(this.message);

  @override
  List<Object?> get props => [message];
}
