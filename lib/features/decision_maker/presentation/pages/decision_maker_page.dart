import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scout_camp_lider/features/decision_maker/domain/entities/situation.dart';
import 'package:scout_camp_lider/features/decision_maker/presentation/bloc/decision_maker_bloc.dart';

import '../../../../injection_container.dart';

class DecisionMakerPage extends StatelessWidget {
  const DecisionMakerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decision Maker'),
      ),
      body: BlocProvider(
        create: (context) => sl<DecisionMakerBloc>(),
        child: SafeArea(
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightGreen,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 2.0 / 4.0,
                    child: Center(
                      child: BlocBuilder<DecisionMakerBloc, DecisionMakerState>(
                        builder: (context, state) {
                          if (state is SituationLoadSuccess)
                            return Text(state.situation.description,
                                style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold));
                          else if (state is SituationLoadInProgress) {
                            return CircularProgressIndicator();
                          } else if (state is Error) {
                            return Text(state.message);
                          } else if (state is DecisionMakerInitial) {
                            return Text('Czuwaj! \nZacznijmy nasza grę',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold));
                          } else
                            return Text(state.toString(),
                                style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold));
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocBuilder<DecisionMakerBloc, DecisionMakerState>(
                      builder: (context, state) {
                        if (state is SituationLoadSuccess) {
                          return OptionsButton(
                            nextStory: 3,
                            option: 1,
                            situation: state.situation,
                          );
                        } else if (state is DecisionMakerInitial) {
                          return ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.lime)),
                              onPressed: () =>
                                  BlocProvider.of<DecisionMakerBloc>(context)
                                      .add(OptionChosened(1, 1)),
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 5 / 12,
                                child: Text(
                                    'Zaczynamy obóz fdnafjlkd fdhaf fdlk fklgj klfd jgkldfs fdgklgfdjkldfgjofdgjiotejrmvioerj dnvierjgireg fh gioer jgklgjie j grilerji jgjr gi j jrei jkljgroj'),
                              ));
                        } else {
                          return Container(
                            child: null,
                          );
                        }
                      },
                    ),
                    BlocBuilder<DecisionMakerBloc, DecisionMakerState>(
                      builder: (context, state) {
                        if (state is SituationLoadSuccess)
                          return OptionsButton(
                              nextStory: 3,
                              option: 2,
                              situation: state.situation);

                        return Container(child: null);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionsButton extends StatelessWidget {
  final Situation situation;
  final int option;
  final int nextStory;
  const OptionsButton(
      {required this.situation, required this.option, required this.nextStory});

  @override
  Widget build(BuildContext context) {
    String optionText = '';
    if (option == 1) {
      optionText = situation.option1;
    } else
      optionText = situation.option2;
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lime)),
        onPressed: () => BlocProvider.of<DecisionMakerBloc>(context)
            .add(OptionChosened(nextStory, option)),
        child: Container(
          width: MediaQuery.of(context).size.width * 5 / 12,
          child: Text(
            optionText,
          ),
        ));
  }
}
