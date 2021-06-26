import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scout_camp_lider/features/decision_maker/presentation/pages/decision_maker_page.dart';
import 'injection_container.dart' as di;

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  Bloc.observer = SimpleBlocObserver();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decision Maker',
      home: DecisionMakerPage(),
      theme: ThemeData(
          primaryColor: Colors.teal[900], accentColor: Colors.green[700]),
    );
  }
}
