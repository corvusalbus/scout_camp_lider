import 'package:flutter/cupertino.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';
import 'package:meta/meta.dart';

class SituationModel extends Situation {
  SituationModel(
      {required description,
      required option1,
      required option2,
      required consequencesOfOption1,
      required consequencesOfOption2})
      : super(
            description: description,
            option1: option1,
            option2: option2,
            consequencesOfOption1: consequencesOfOption1,
            consequencesOfOption2: consequencesOfOption2);

  factory SituationModel.fromJson(Map<String, dynamic> json) {
    return SituationModel(
        description: json['description'],
        option1: json['option1'],
        option2: json['option2'],
        consequencesOfOption1: json['consequencesOfOption1'].cast<int>(),
        consequencesOfOption2: json['consequencesOfOption2'].cast<int>());
  }
}
