import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_camp_lider/core/error/exteption.dart';
import 'package:scout_camp_lider/features/decision_maker/data/datasources/situation_local_data_source.dart';
import 'package:scout_camp_lider/features/decision_maker/data/models/situatuation_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockFile extends Mock implements File {
  @override
  String readAsStringSync({Encoding encoding = utf8}) => super.noSuchMethod(
        Invocation.getter(#readAsStringSync),
        returnValue: '',
      );
}

void main() {
  MockFile mockFile = MockFile();
  SituationLocalDataSourceImpl dataSource =
      SituationLocalDataSourceImpl(mockFile);

  // File file = File('situation.json');
  // setUp(() {
  //   mockFile = MockFile();
  //   dataSource = SituationLocalDataSourceImpl(mockFile);
  // });

  group('getFirstSituation', () {
    final tSituationModel =
        SituationModel.fromJson(jsonDecode(fixture('situation.json')));

    test('should return first Situation from file ', () async {
      when(mockFile.readAsStringSync()).thenReturn(fixture('situations.json'));

      final result = await dataSource.getFirstSituation();

      verify(mockFile.readAsStringSync());
      expect(result, tSituationModel);
    });

    test('should throw a FileException when there is empty situation file',
        () async {
      when(mockFile.readAsStringSync()).thenReturn('');

      final call = dataSource.getFirstSituation;

      expectLater(() => call(), throwsA(isA<FileException>()));
    });

    test(
        'should throw a FileException when situations file is in incorrect format',
        () async {
      when(mockFile.readAsStringSync()).thenReturn('situation:"none"]');

      final call = dataSource.getFirstSituation;

      expectLater(() => call(), throwsA(isA<FileException>()));
    });
    test(
        'should throw a FileException when situations file is in incorrect format',
        () async {
      when(mockFile.readAsStringSync()).thenReturn('[{"situation":"none"}]');

      final call = dataSource.getFirstSituation;

      expectLater(() => call(), throwsA(isA<FileException>()));
    });
  });

  group('getNextSituation', () {
    final tSituationModel =
        SituationModel.fromJson(jsonDecode(fixture('situationSecond.json')));

    test('should return second Situation from file ', () async {
      when(mockFile.readAsStringSync()).thenReturn(fixture('situations.json'));

      final result = await dataSource.getNextSituation(currentSituation: 1);

      verify(mockFile.readAsStringSync());
      expect(result, tSituationModel);
    });

    test('should return second Situation from file ', () async {
      when(mockFile.readAsStringSync()).thenReturn(fixture('situations.json'));

      final result = await dataSource.getNextSituation(currentSituation: 7);

      verify(mockFile.readAsStringSync());
      expect(result, tSituationModel);
    });

    test('should throw a FileException when there is empty situation file',
        () async {
      when(mockFile.readAsStringSync()).thenReturn('');

      final call = dataSource.getNextSituation;

      expectLater(
          () => call(currentSituation: 1), throwsA(isA<FileException>()));
    });

    test(
        'should throw a FileException when situations file is in incorrect format',
        () async {
      when(mockFile.readAsStringSync()).thenReturn('situation:"none"]');

      final call = dataSource.getNextSituation;

      expectLater(
          () => call(currentSituation: 1), throwsA(isA<FileException>()));
    });
    test(
        'should throw a FileException when situations file is in incorrect format',
        () async {
      when(mockFile.readAsStringSync()).thenReturn('[{"situation":"none"}]');

      final call = dataSource.getNextSituation;

      expectLater(
          () => call(currentSituation: 1), throwsA(isA<FileException>()));
    });
  });
}
