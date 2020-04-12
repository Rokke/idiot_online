import 'package:flutter/material.dart';
import 'package:idiot_online/models/play_card.dart';
import 'package:idiot_online/my_widgets/card.dart';

class CardStock extends StatefulWidget {
  final int numberOfCards;
  CardStock(this.numberOfCards, {Key key}) : super(key: key);

  @override
  _CardStockState createState() => _CardStockState();
}

class _CardStockState extends State<CardStock> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = List<Widget>();
    for (int i = 0; i < widget.numberOfCards; i++)
      children.add(Positioned(right: i / 2, bottom: i / 2, child: CardWidget(PlayCard(1, PlayCardType.Club))));
    return Container(
      color: Colors.yellow,
      width: 200,
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        children: children,
      ),
    );
  }
}
