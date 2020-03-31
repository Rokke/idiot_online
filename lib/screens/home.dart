import 'package:flutter/material.dart';
import 'package:idiot_online/models/card.dart';
import 'package:idiot_online/my_widgets/card.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PlayCard playCard = PlayCard(2, PlayCardType.Spade, show: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Idiot")),
      backgroundColor: Colors.green,
      body: Stack(
        children: <Widget>[
          Positioned(
              left: 40,
              top: 50,
              child: GestureDetector(
                onTap: () {
                  print('test');
                  playCard.show = !playCard.show;
                  setState(() => {});
                },
                child: AnimatedContainer(duration: Duration(seconds: 2), child: CardWidget(playCard)),
              )),
          Positioned(left: 140, top: 50, child: CardWidget(PlayCard(13, PlayCardType.Diamond))),
          Positioned(left: 40, top: 150, child: CardWidget(PlayCard(1, PlayCardType.Club, show: true))),
          AnimatedPositioned(
              duration: Duration(seconds: 2), left: 240, top: 150, child: CardWidget(PlayCard(2, PlayCardType.Heart))),
        ],
      ),
    );
  }
}
