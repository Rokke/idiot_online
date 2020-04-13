import 'package:flutter/material.dart';
import 'package:idiot_online/models/constants.dart';
import 'package:idiot_online/models/game.dart';
import 'package:idiot_online/models/player.dart';
import 'package:idiot_online/my_widgets/register_player.dart';
import 'package:provider/provider.dart';

class CreateGame extends StatefulWidget {
  CreateGame({Key key}) : super(key: key);

  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  List<Player> _players = [Player.createDefault()];
  _createNewGame(BuildContext context) {
    Game _game = Provider.of<Game>(context, listen: false);
    _game.startGame(_players);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Idiot - lag spill")),
      body: Stack(children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _players
              .map((player) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: RegisterPlayer(
                      player,
                      onRemove: () => setState(() {
                        _players.remove(player);
                      }),
                    ),
                  ))
              .toList(),
        ),
        Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RaisedButton(
                onPressed: () => Provider.of<Game>(context, listen: false).initializeGame(),
                child: Text('Tilbake'),
              ),
              RaisedButton(
                onPressed: () => _createNewGame(context),
                child: Text('Start'),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _players.length < 4
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 50,
              ),
              onPressed: () => setState(() {
                _players.add(Player.createDefault()
                  ..color = personColorMap.values.firstWhere(
                      (color) => !_players.any((player) => player.color == color),
                      orElse: () => personColorMap.values.first));
              }),
            )
          : null,
    );
  }
}
