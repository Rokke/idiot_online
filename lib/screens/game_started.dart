import 'package:flutter/material.dart';
import 'package:idiot_online/models/game.dart';
import 'package:idiot_online/my_widgets/card.dart';
import 'package:idiot_online/my_widgets/card_stock.dart';
import 'package:idiot_online/my_widgets/mydeck.dart';
import 'package:provider/provider.dart';

class GameView extends StatefulWidget {
  GameView({Key key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
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
        print('No cards playet yet');
      if (game.isStarted) _children.add(Positioned(bottom: 0, child: MyDeckWidget(game.fetchPlayer(0))));
      return Stack(
        children: _children,
      );
    });
  }
}
