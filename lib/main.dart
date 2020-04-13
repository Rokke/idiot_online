import 'package:flutter/material.dart';
import 'package:idiot_online/models/game.dart';
import 'package:idiot_online/screens/create_game.dart';
import 'package:idiot_online/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => Game(numberOfDecs: 1), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idiot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
//        brightness: Brightness.dark,
      ),
      home: Consumer<Game>(builder: (_, game, __) {
        //TODO: Not good since this will trigger for all changes and repaint everything
        print('MyApp build(${game.state})');
        switch (game.state) {
          case GameState.create:
            return CreateGame();
          default:
            return HomeView();
        }
      }),
    );
  }
}
