import 'package:flutter/material.dart';
import 'package:idiot_online/models/game.dart';
import 'package:idiot_online/models/player.dart';
import 'package:idiot_online/screens/game_started.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

_startQuickGame(BuildContext context) {
  Game game = Provider.of<Game>(context, listen: false);
  game.createNewGame();
  game.startGame([Player("Odin"), Player("Ragnar")]);
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Idiot"), actions: [
        IconButton(
            icon: Icon(Icons.local_gas_station),
            onPressed: () => Provider.of<Game>(context, listen: false).printDebugInfo()),
      ]),
      body: Consumer<Game>(
        builder: (_, game, __) {
          return game.state == GameState.nothing
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RaisedButton(onPressed: () => _startQuickGame(context), child: Text('Quick game')),
                    RaisedButton(
                        onPressed: () => Provider.of<Game>(context, listen: false).createNewGame(),
                        child: Text('Start')),
                  ],
                ))
              : GameView();
        },
      ),
    );
  }
}
