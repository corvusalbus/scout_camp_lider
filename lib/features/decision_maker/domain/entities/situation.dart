import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Situation extends Equatable {
  final String description;
  final String option1;
  final String option2;
  final List<int> consequencesOfOption1;
  final List<int> consequencesOfOption2;

  Situation(
      {required this.description,
      required this.option1,
      required this.option2,
      required this.consequencesOfOption1,
      required this.consequencesOfOption2});

  @override
  List<Object> get props => [
        description,
        option1,
        option2,
        consequencesOfOption1,
        consequencesOfOption2
      ];
}
