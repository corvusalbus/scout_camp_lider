import 'package:equatable/equatable.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/usecases/get_next_situation.dart';

abstract class UseCase<Type, preParams> {
  Future<Type> call(preParams params);
}

abstract class preParams extends Equatable {}

class Params extends preParams {
  final int currentSituation;
  Params({required this.currentSituation});

  @override
  List<Object?> get props => [currentSituation];
}

class NonParams extends preParams {
  @override
  List<Object> get props => [];
}
