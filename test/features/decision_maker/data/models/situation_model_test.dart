import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:scout_camp_lider/features/decision_maker/data/models/situatuation_model.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tSituationModel = SituationModel(
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.',
      option1: 'Option 1 Suspendisse imperdiet sapien quis mi scelerisque',
      option2: 'Option 2 Mauris interdum viverra lacinia.',
      consequencesOfOption1: [0, -4, 2, 1],
      consequencesOfOption2: [10, 2, 3, -4]);
  test('schould be subclass of Situation entity', () async {
    expect(tSituationModel, isA<Situation>());
  });

  group(
    'fromJson',
    () {
      test('should return a valid model with standard situation input', () {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('situation.json'));
        //act
        final result = SituationModel.fromJson(jsonMap);
        //assert
        expect(result, tSituationModel);
      });
    },
  );
}
