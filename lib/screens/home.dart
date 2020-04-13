import 'package:flutter/material.dart';
import 'package:idiot_online/models/play_card.dart';
import 'package:idiot_online/models/game.dart';
import 'package:idiot_online/models/player.dart';
import 'package:idiot_online/my_widgets/card.dart';
import 'package:idiot_online/my_widgets/card_stock.dart';
import 'package:idiot_online/my_widgets/mydeck.dart';
import 'package:idiot_online/screens/game_started.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Idiot"), actions: [
        IconButton(
            icon: Icon(Icons.refresh), onPressed: () => Provider.of<Game>(context, listen: false).startNewGame()),
        IconButton(
            icon: Icon(Icons.local_gas_station),
            onPressed: () => Provider.of<Game>(context, listen: false).printDebugInfo()),
      ]),
      backgroundColor: Colors.green,
      body: GameView(),
    );
  }
}
