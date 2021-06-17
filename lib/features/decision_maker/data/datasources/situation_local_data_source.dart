import 'dart:convert';
import 'dart:io';
import 'package:scout_camp_lider/core/error/exteption.dart';
import 'package:scout_camp_lider/features/decision_maker/data/models/situatuation_model.dart';

abstract class SituationLocalDataSource {
  ///Get next situations from situations.json
  ///
  ///Throws a [FileException] for all errors.
  Future<SituationModel> getNextSituation({int? currentSituation});

  ///Get a first situation from situations.json
  ///
  ///Throws a [FileException] for all errors.
  Future<SituationModel> getFirstSituation();
}

class SituationLocalDataSourceImpl implements SituationLocalDataSource {
  final File file;

  SituationLocalDataSourceImpl({required this.file});

  @override
  Future<SituationModel> getFirstSituation() async {
    return getNextSituation(currentSituation: 0);
  }

  @override
  Future<SituationModel> getNextSituation({int? currentSituation}) async {
    final String situationsJson =
        //File('lib/assets/situations.json').readAsStringSync();
        file.readAsStringSync();
    if (!(situationsJson == '')) {
      try {
        final Iterable list = jsonDecode(situationsJson);

        final List<SituationModel> situationList = List<SituationModel>.from(
            list.map((model) => SituationModel.fromJson(model)));

        final result = situationList[(currentSituation ?? 0) % list.length];
        return result;
      } catch (e) {
        throw FileException(
            message:
                'there is something wrong with situations file. error:{$e.tosString()}');
      }
    } else
      throw FileException(message: 'Situations file is empty');
  }
}
