import 'package:flutter/material.dart';
import 'package:idiot_online/models/play_card.dart';
import 'package:idiot_online/my_widgets/card.dart';

/// This is used both for the draw deck and the played deck. lastCard it != null if it's the played deck.
class CardStock extends StatefulWidget {
  final int numberOfCards;
  final PlayCard lastCard; // This is if it's the cards played and the top card to show
  final Function onTap; // Clicked on the deck
  CardStock(this.numberOfCards, {@required this.onTap, this.lastCard, Key key}) : super(key: key);

  @override
  _CardStockState createState() => _CardStockState();
}

class _CardStockState extends State<CardStock> {
  @override
  Widget build(BuildContext context) {
    print('CardStock build(${widget.lastCard})');
    List<Widget> children = List<Widget>();
    for (int i = 0; i < widget.numberOfCards - 1; i++) // -1 so that the last card drawn can be clicked
      children.add(widget.lastCard != null
          ? Positioned(left: i.toDouble(), bottom: i.toDouble(), child: CardWidget(PlayCard(3, PlayCardType.Diamond)))
          : Positioned(right: i / 2, bottom: i / 2, child: CardWidget(PlayCard(3, PlayCardType.Heart))));
    children.add(widget.lastCard != null
        ? Positioned(
            left: widget.numberOfCards - 1.0,
            bottom: widget.numberOfCards - 1.0,
            child: GestureDetector(onTap: () => widget.onTap(), child: CardWidget(widget.lastCard)))
        : Positioned(
            right: (widget.numberOfCards - 1) / 2,
            bottom: (widget.numberOfCards - 1) / 2,
            child: GestureDetector(onTap: () => widget.onTap(), child: CardWidget(PlayCard(3, PlayCardType.Spade)))));
    return Container(
      color: Colors.green[400],
      width: CardWidget.cardWidth + (widget.numberOfCards - 1) / (widget.lastCard == null ? 2 : 1),
      height: CardWidget.cardHeight + (widget.numberOfCards - 1) / (widget.lastCard == null ? 2 : 1),
      child: Stack(
        children: children,
      ),
    );
  }
}
