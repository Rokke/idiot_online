import 'package:flutter/material.dart';
import 'package:idiot_online/models/player.dart';
import 'package:idiot_online/my_widgets/card.dart';

class MyDeckWidget extends StatefulWidget {
  final Player _player;
  final double sizeFactor;
  MyDeckWidget(this._player, {this.sizeFactor = 1});
  @override
  _MyDeckWidgetState createState() => _MyDeckWidgetState();
}

class _MyDeckWidgetState extends State<MyDeckWidget> {
  @override
  Widget build(BuildContext context) {
    double widthSize =
            MediaQuery.of(context).size.width * widget.sizeFactor, // Helpers for calculating sizes if not the main hand
        heightSize = CardWidget.cardHeight * 1.75 * widget.sizeFactor,
        cardWidthSize = CardWidget.cardWidth * widget.sizeFactor,
        cardHeightSize = CardWidget.cardHeight * widget.sizeFactor;
    List<Widget> _childrenHand = List<Widget>();
    for (int i = 0; i < widget._player.numberOfCardsOnHand; i++) {
      _childrenHand.add(Positioned(
          left: i * (widthSize - cardWidthSize) / (widget._player.numberOfCardsOnHand - 1),
          child: CardWidget(
            widget._player.cardsHand[i],
            showCard: true,
          )));
    }
    return Container(
      constraints: BoxConstraints(
//          minWidth: MediaQuery.of(context).size.width,
          maxWidth: widthSize,
//          minHeight: CardWidget.cardHeight * 1.75*widget.sizeFactor,
          maxHeight: heightSize),
      color: widget._player.color,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: widthSize / 2 - 2 * cardWidthSize,
            child: Container(
              alignment: Alignment.center,
              height: cardHeightSize * .75,
              width: 4 * cardWidthSize,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget._player.cardsTop
                      .map((e) =>
                          SizedBox(width: cardWidthSize * .75, height: cardHeightSize * .75, child: CardWidget(e)))
                      .toList()),
            ),
          ),
          widget._player.numberOfCardsOnHand > 0
              ? Positioned(
                  width: MediaQuery.of(context).size.width,
                  height: 80 * widget.sizeFactor,
                  bottom: 0,
                  child: Stack(
                    children: _childrenHand,
                  ))
              : Container(),
          Positioned(
            bottom: 75 * widget.sizeFactor,
            right: 0,
            child: GestureDetector(
              onTap: () => widget._player.printMyCards(),
              child: Text(
                widget._player.name,
                textAlign: TextAlign.end,
                softWrap: false,
                style: widget.sizeFactor == 1
                    ? Theme.of(context).textTheme.headline3
                    : Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
