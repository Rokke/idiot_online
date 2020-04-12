import 'package:flutter/material.dart';
import 'package:idiot_online/models/player.dart';
import 'package:idiot_online/my_widgets/card.dart';

class MyDeckWidget extends StatefulWidget {
  final Player _player;
  MyDeckWidget(this._player);
  @override
  _MyDeckWidgetState createState() => _MyDeckWidgetState();
}

class _MyDeckWidgetState extends State<MyDeckWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          maxWidth: MediaQuery.of(context).size.width,
          minHeight: CardWidget.cardHeight * 2,
          maxHeight: CardWidget.cardHeight * 2),
      color: Colors.green[400],
      child: Stack(
        children: <Widget>[
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 2 * CardWidget.cardWidth,
            child: Container(
              alignment: Alignment.center,
              color: Colors.green[200],
              height: CardWidget.cardHeight,
              width: 4 * CardWidget.cardWidth,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget._player.cardsTop.map((e) => CardWidget(e)).toList()),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => widget._player.printMyCards(),
              child: Text(
                widget._player.name,
                textAlign: TextAlign.end,
                softWrap: false,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
