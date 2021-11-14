import 'package:flutter/services.dart' show rootBundle;
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
  final String situationsJson = '''[
    {
        "description":"1 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.",
        "option1":"Option 1 Suspendisse imperdiet sapien quis mi scelerisque",
        "option2":"Option 2 Mauris interdum viverra lacinia.",
        "consequencesOfOption1":[0, -4, 2, 1],    
        "consequencesOfOption2":[10, 2, 3, -4]
    },
    {
        "description":"2 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.",
        "option1":"Option 1 Suspendisse imperdiet sapien quis mi scelerisque",
        "option2":"Option 2 Mauris interdum viverra lacinia.",
        "consequencesOfOption1":[0, -4, 2, 1],    
        "consequencesOfOption2":[10, 2, 3, -4]
    },
    {
        "description":"3 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.",
        "option1":"Option 1 Suspendisse imperdiet sapien quis mi scelerisque",
        "option2":"Option 2 Mauris interdum viverra lacinia.",
        "consequencesOfOption1":[0, -4, 2, 1],    
        "consequencesOfOption2":[10, 2, 3, -4]
    },
    {
        "description":"4 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.",
        "option1":"Option 1 Suspendisse imperdiet sapien quis mi scelerisque",
        "option2":"Option 2 Mauris interdum viverra lacinia.",
        "consequencesOfOption1":[0, -4, 2, 1],    
        "consequencesOfOption2":[10, 2, 3, -4]
    },
    {
        "description":"5 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.",
        "option1":"Option 1 Suspendisse imperdiet sapien quis mi scelerisque",
        "option2":"Option 2 Mauris interdum viverra lacinia.",
        "consequencesOfOption1":[0, -4, 2, 1],    
        "consequencesOfOption2":[10, 2, 3, -4]
    },
    {
        "description":"6 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue nulla ut orci mollis, a rutrum lorem condimentum. Maecenas posuere dolor cursus quam varius rhoncus.",
        "option1":"Option 1 Suspendisse imperdiet sapien quis mi scelerisque",
        "option2":"Option 2 Mauris interdum viverra lacinia.",
        "consequencesOfOption1":[0, -4, 2, 1],    
        "consequencesOfOption2":[10, 2, 3, -4]
    }
]''';
  //await rootBundle.loadString('assets/situations.json');
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
  sl.registerLazySingleton(() => situationsJson);

  // File('lib\assets\situations.json')
}
