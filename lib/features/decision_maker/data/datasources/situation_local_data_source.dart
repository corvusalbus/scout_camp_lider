import 'dart:convert';
import 'dart:io';

import '../../../../core/error/exteption.dart';
import '../models/situatuation_model.dart';

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
  final String _situationsJson; // = File('lib\assets\situations.json');

  SituationLocalDataSourceImpl(this._situationsJson);

  @override
  Future<SituationModel> getFirstSituation() async {
    return getNextSituation(currentSituation: 0);
  }

  @override
  Future<SituationModel> getNextSituation({int? currentSituation}) async {
    if (!(_situationsJson == '')) {
      try {
        final Iterable list = jsonDecode(_situationsJson);

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
