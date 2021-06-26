import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:scout_camp_lider/features/decision_maker/data/datasources/situation_local_data_source.dart';
import 'package:scout_camp_lider/features/decision_maker/data/repositories/situation_repository_impl.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/repositories/situation_repository.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/usecases/get_first_situation.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/usecases/get_next_situation.dart';
import 'package:scout_camp_lider/features/decision_maker/presentation/bloc/decision_maker_bloc.dart';

final sl = GetIt.instance; //service locator
Future<void> init() async {
  //!features - DecisionMaker
  //Bloc
  sl.registerFactory(
    () => DecisionMakerBloc(
      getFirstSituation: sl(),
      getNextSituation: sl(),
    ),
  );

  //usecases
  sl.registerLazySingleton(() => GetFirstSituation(sl()));
  sl.registerLazySingleton(() => GetNextSituation(sl()));

  //repository
  sl.registerLazySingleton<SituationRepository>(
      () => SituationRepositoryImpl(localDataSource: sl()));

  //data sources
  sl.registerLazySingleton<SituationLocalDataSource>(
      () => SituationLocalDataSourceImpl(sl()));

  //!Core

  //!External
  // sl.registerLazySingleton(() => File(sl()));
  sl.registerLazySingleton(() => File('assets/situations.json'));

  // File('lib\assets\situations.json')
}
