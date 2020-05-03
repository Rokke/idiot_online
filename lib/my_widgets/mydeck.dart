import 'package:flutter/material.dart';
import 'package:idiot_online/models/game.dart';
import 'package:idiot_online/models/player.dart';
import 'package:idiot_online/my_widgets/card.dart';
import 'package:idiot_online/my_widgets/player_deck/deck_on_hand.dart';
import 'package:provider/provider.dart';

class MyDeckWidget extends StatefulWidget {
  final Player _player;
  final double sizeFactor;
  MyDeckWidget(this._player, {this.sizeFactor = 1});
  @override
  _MyDeckWidgetState createState() => _MyDeckWidgetState();
}

class _MyDeckWidgetState extends State<MyDeckWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(builder: (_, game, __) {
      bool isMe = game.isPlayerMe(widget._player);
      double widthSize = MediaQuery.of(context).size.width *
              widget.sizeFactor, // Helpers for calculating sizes if not the main hand
          heightSize = CardWidget.cardHeight * 1.75 * widget.sizeFactor,
          cardWidthSize = CardWidget.cardWidth * widget.sizeFactor,
          cardHeightSize = CardWidget.cardHeight * widget.sizeFactor;
      return Container(
        constraints: BoxConstraints(maxWidth: widthSize, maxHeight: heightSize),
        color: widget._player.color,
        child: Stack(
          children: <Widget>[
            Positioned(
              // Card on table
              left: widthSize / 2 - 2 * cardWidthSize,
              child: Container(
                alignment: Alignment.center,
                height: cardHeightSize * .75,
                width: 4 * cardWidthSize,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget._player.cardOnTable
                        .asMap()
                        .map((index, playCard) => MapEntry(
                            index,
                            SizedBox(
                                width: cardWidthSize * .75,
                                height: cardHeightSize * .75,
                                child: playCard == null
                                    ? Container()
                                    : CardWidget(playCard, widget._player.shouldShowCardOnTable(index),
                                        sizeFactor: widget.sizeFactor,
                                        onTap: isMe
                                            ? () {
                                                if (widget._player.drawFromCardOnTable(index)) setState(() {});
                                              }
                                            : null))))
                        .values
                        .toList()),
              ),
            ),
            if (widget._player.numberOfCardsOnHand > 0)
              Positioned(
                  width: MediaQuery.of(context).size.width * widget.sizeFactor,
                  height: 80 * widget.sizeFactor,
                  bottom: 0,
                  child: DeckOnHand(widget._player, isMe, widget.sizeFactor,
                      onCardDrawn: (index) => setState(() {
                            if (widget._player.state == PlayerState.initial)
                              widget._player.drawFromHandToTable(index);
                            else if (game.isStarted && widget._player.state == PlayerState.myTurn)
                              setState(() => game.addCardToPlayed = widget._player.playCard(index));
                          }))),
            Positioned(
              bottom: 75 * widget.sizeFactor,
              right: 0,
              child: GestureDetector(
                //TODO: Must be removed when ready
                onTap: () => widget._player.printMyCards(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
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
            ),
            if (isMe && widget._player.state == PlayerState.swapping)
              Positioned(
                  right: 4,
                  top: 0,
                  child: FlatButton(
                      color: Colors.black38,
                      hoverColor: Colors.black54,
                      textColor: Colors.white,
                      onPressed: widget._player.numberOfCardsOnHand == 3
                          ? () => setState(() {
                                widget._player.state = PlayerState.ready;
                              })
                          : null,
                      child: Text('Ferdig')))
          ],
        ),
      );
    });
  }
}
