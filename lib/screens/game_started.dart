import 'package:flutter/material.dart';
import 'package:idiot_online/models/game.dart';
import 'package:idiot_online/my_widgets/card_stock.dart';
import 'package:idiot_online/my_widgets/mydeck.dart';
import 'package:provider/provider.dart';

class GameView extends StatefulWidget {
  GameView({Key key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (context, game, _) {
      print('GameView consumer(${game.lastCardPlayed})');
      List<Widget> _children = List<Widget>();
      _children.add(Positioned(
        right: MediaQuery.of(context).size.width / 2 - 5,
        bottom: MediaQuery.of(context).size.height / 2,
        child: CardStock(
          game.numberOfCardsInStock,
          onTap: () => setState(() {
            game.addCardToPlayed = game.drawCardFromStock;
          }),
        ),
      ));
      if (game.numberOfCardsPlayed > 0)
        _children.add(Positioned(
          left: MediaQuery.of(context).size.width / 2 + 10,
          bottom: MediaQuery.of(context).size.height / 2,
          child: CardStock(
            game.numberOfCardsPlayed,
            onTap: () => setState(() {
              game.fetchPlayer(0).drawCardList = game.drawCardsPlayed;
            }),
            lastCard: game.lastCardPlayed,
          ),
        ));
      else
        print('No cards played yet');
      _children.add(Positioned(
        left: 0,
        right: 0,
        top: MediaQuery.of(context).size.height / 2 + 150,
        child: Center(
          child: Container(
            color: game.fetchPlayer(game.playersTurn).color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(game.fetchPlayer(game.playersTurn).name, style: Theme.of(context).textTheme.headline3),
            ),
          ),
        ),
      ));
      _children.add(Positioned(
        left: 0,
        right: 0,
        top: MediaQuery.of(context).size.height / 2 + 230,
        child: Center(
          child: Container(
            color: game.fetchPlayer(game.playersTurn).color,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                  game.state == GameState.initial ? "Bytting av kort" : "Legg på kort, trekk inn eller ta en sjanse",
                  style: Theme.of(context).textTheme.headline5),
            ),
          ),
        ),
      ));
      _children.add(Positioned(bottom: 0, child: MyDeckWidget(game.fetchPlayer(0))));
      _children.add(Positioned(
          top: 0,
          left: MediaQuery.of(context).size.width * .25,
          child: RotatedBox(
            quarterTurns: 2,
            child: MyDeckWidget(
              game.fetchPlayer(1),
              sizeFactor: 0.5,
            ),
          )));
      _children.add(Positioned(
          top: 150,
          child: RotatedBox(
            quarterTurns: 1,
            child: MyDeckWidget(
              game.fetchPlayer(2),
              sizeFactor: 0.5,
            ),
          )));
      _children.add(Positioned(
          top: 150,
          right: 0,
          child: RotatedBox(
            quarterTurns: 3,
            child: MyDeckWidget(
              game.fetchPlayer(3),
              sizeFactor: 0.5,
            ),
          )));
      return Stack(
        children: _children,
      );
    });
  }
}
