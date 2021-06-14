import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NonParams extends Equatable {
  @override
  List<Object> get props => [];
}
