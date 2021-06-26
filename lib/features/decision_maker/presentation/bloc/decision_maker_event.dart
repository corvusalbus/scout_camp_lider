part of 'decision_maker_bloc.dart';

abstract class DecisionMakerEvent extends Equatable {
  const DecisionMakerEvent();
}

class OptionChosened extends DecisionMakerEvent {
  final int actualSituation;
  final int whatOption;

  OptionChosened(this.actualSituation, this.whatOption);

  @override
  List<Object?> get props => [actualSituation, whatOption];
}

class GameStarted extends DecisionMakerEvent {
  @override
  List<Object?> get props => [];
}

class GameEnded extends DecisionMakerEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
