import 'package:flutter/material.dart';
import 'package:idiot_online/models/player.dart';

class MyDeckWidget extends StatefulWidget {
  final Player _player;
  MyDeckWidget(this._player);
  @override
  _MyDeckWidgetState createState() => _MyDeckWidgetState();
}

class _MyDeckWidgetState extends State<MyDeckWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(children:widget._player.cardsBottom.map((e) => Text(e.cardValue.toString())).toList()),
         Container(
            color: Colors.red, height: 400, width: MediaQuery.of(context).size.width,
        ),
      Positioned(child: Text(widget._player.name, style: Theme.of(context).textTheme.headline2,),top: 5,left: 10,),

      ],
    );
  }
}