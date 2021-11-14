import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_camp_lider/core/error/exteption.dart';
import 'package:scout_camp_lider/features/decision_maker/data/datasources/situation_local_data_source.dart';
import 'package:scout_camp_lider/features/decision_maker/data/models/situatuation_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final String tSituationsJson = fixture('situations.json');
  SituationLocalDataSourceImpl dataSource =
      SituationLocalDataSourceImpl(tSituationsJson);

  // File file = File('situation.json');
  // setUp(() {
  //   mockFile = MockFile();
  //   dataSource = SituationLocalDataSourceImpl(mockFile);
  // });

  group('getFirstSituation', () {
    final tSituationModel =
        SituationModel.fromJson(jsonDecode(fixture('situation.json')));

    test('should return first Situation from file ', () async {
      //when(mockFile.readAsStringSync()).thenReturn(fixture('situations.json'));

      final result = await dataSource.getFirstSituation();

      //verify(mockFile.readAsStringSync());
      expect(result, tSituationModel);
    });

    test('should throw a FileException when there is empty situation file',
        () async {
      dataSource = SituationLocalDataSourceImpl('');

      final call = dataSource.getFirstSituation;

      expectLater(() => call(), throwsA(isA<FileException>()));
    });

    test(
        'should throw a FileException when situations file is in incorrect format',
        () async {
      dataSource = SituationLocalDataSourceImpl('situation:"none"]');

      final call = dataSource.getFirstSituation;

      expectLater(() => call(), throwsA(isA<FileException>()));
    });
    test(
        'should throw a FileException when situations file is in incorrect format',
        () async {
      dataSource = SituationLocalDataSourceImpl('[{"situation":"none"}]');

      final call = dataSource.getFirstSituation;

      expectLater(() => call(), throwsA(isA<FileException>()));
    });
  });

  group('getNextSituation', () {
    final tSituationModel =
        SituationModel.fromJson(jsonDecode(fixture('situationSecond.json')));

    test('should return second Situation from file ', () async {
      dataSource = SituationLocalDataSourceImpl(fixture('situations.json'));

      final result = await dataSource.getNextSituation(currentSituation: 1);

      expect(result, tSituationModel);
    });

    test('should return second Situation from file ', () async {
      dataSource = SituationLocalDataSourceImpl(fixture('situations.json'));

      final result = await dataSource.getNextSituation(currentSituation: 7);

      expect(result, tSituationModel);
    });

    test('should throw a FileException when there is empty situation file',
        () async {
      dataSource = SituationLocalDataSourceImpl('');

      final call = dataSource.getNextSituation;

      expectLater(
          () => call(currentSituation: 1), throwsA(isA<FileException>()));
    });

    test(
        'should throw a FileException when situations file is in incorrect format',
        () async {
      dataSource = SituationLocalDataSourceImpl('situation:"none"]');

      final call = dataSource.getNextSituation;

      expectLater(
          () => call(currentSituation: 1), throwsA(isA<FileException>()));
    });
    test(
        'should throw a FileException when situations file is in incorrect format',
        () async {
      dataSource = SituationLocalDataSourceImpl('[{"situation":"none"}]');

      final call = dataSource.getNextSituation;

      expectLater(
          () => call(currentSituation: 1), throwsA(isA<FileException>()));
    });
  });
}
