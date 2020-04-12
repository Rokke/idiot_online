import 'package:flutter/material.dart';
import 'package:idiot_online/models/play_card.dart';
import 'package:idiot_online/models/game.dart';
import 'package:idiot_online/models/player.dart';
import 'package:idiot_online/my_widgets/card.dart';
import 'package:idiot_online/my_widgets/card_stock.dart';
import 'package:idiot_online/my_widgets/mydeck.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PlayCard playCard = PlayCard(2, PlayCardType.Spade, show: false);

  @override
  Widget build(BuildContext context) {
    final Player player=Player("odofd");
    Provider.of<Game>(context,listen: false).addPlayer(player);
    return Scaffold(
      appBar: AppBar(title: Text("Idiot")),
      backgroundColor: Colors.green,
      body: Stack(
        children: <Widget>[
          Positioned(
              width: 300,
              child: GestureDetector(
                onTap: () {
                  print('test');
                  playCard.show = !playCard.show;
                  setState(() => {});
                },
                child: CardStock(Provider.of<Game>(context, listen: false).numberOfCardsInStock),
              )),
              Positioned(bottom: 20,child: MyDeckWidget(player)),
        ],
      ),
    );
  }
}
