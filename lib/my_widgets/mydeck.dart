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
    List<Widget> _childrenHand = List<Widget>();
    for (int i = 0; i < widget._player.numberOfCardsOnHand; i++) {
      _childrenHand.add(Positioned(
          left:
              i * (MediaQuery.of(context).size.width - CardWidget.cardWidth) / (widget._player.numberOfCardsOnHand - 1),
          child: CardWidget(
            widget._player.cardsHand[i],
            showCard: true,
          )));
    }
    return Container(
      constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          maxWidth: MediaQuery.of(context).size.width,
          minHeight: CardWidget.cardHeight * 1.75,
          maxHeight: CardWidget.cardHeight * 1.75),
      color: Colors.green[400],
      child: Stack(
        children: <Widget>[
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 2 * CardWidget.cardWidth,
            child: Container(
              alignment: Alignment.center,
              height: CardWidget.cardHeight * .75,
              width: 4 * CardWidget.cardWidth,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget._player.cardsTop
                      .map((e) => SizedBox(
                          width: CardWidget.cardWidth * .75, height: CardWidget.cardHeight * .75, child: CardWidget(e)))
                      .toList()),
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
          widget._player.numberOfCardsOnHand > 0
              ? Positioned(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  bottom: 0,
                  child: Stack(
                    children: _childrenHand,
                  ))
              : Container(),
        ],
      ),
    );
  }
}
