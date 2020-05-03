import 'package:flutter/material.dart';
import 'package:idiot_online/models/player.dart';
import 'package:idiot_online/my_widgets/card.dart';

class DeckOnHand extends StatelessWidget {
  final Player player;
  final bool showCards;
  final double sizeFactor;
  final Function onCardDrawn;
  const DeckOnHand(this.player, this.showCards, this.sizeFactor, {this.onCardDrawn, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _childrenHand = List<Widget>();
    double widthSize = MediaQuery.of(context).size.width * sizeFactor,
        cardWidthSize = CardWidget.cardWidth * sizeFactor,
        sizeBetweenCards = (widthSize - cardWidthSize) / (player.numberOfCardsOnHand - 1);
    if (sizeBetweenCards + 20 > cardWidthSize) sizeBetweenCards = cardWidthSize + 20;
    for (int i = 0; i < player.numberOfCardsOnHand; i++) {
      _childrenHand.add(Positioned(
          left: i * sizeBetweenCards,
          child: CardWidget(
            player.cardsHand[i],
            showCards,
            sizeFactor: sizeFactor,
            onTap: player.drawFromHandToTable == null ? null : () => player.drawFromHandToTable(i),
          )));
    }
    return Stack(
      children: _childrenHand,
    );
  }
}
