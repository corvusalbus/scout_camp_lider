part of 'decision_maker_bloc.dart';
abstract class DecisionMakerState extends Equatable {
  const DecisionMakerState();
}
class DecisionMakerInitial extends DecisionMakerState {
  @override
  List<Object> get props => [];
}
