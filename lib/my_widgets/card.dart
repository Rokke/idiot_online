import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idiot_online/models/constants.dart';
import 'package:idiot_online/models/play_card.dart';

class CardWidget extends StatefulWidget {
  static const double cardWidth = 80;
  static const double cardHeight = 120;
  final PlayCard playCard;
  CardWidget(this.playCard, {Key key}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  String get filename {
    switch (widget.playCard.playCardType) {
      case PlayCardType.Club:
        return 'club';
      case PlayCardType.Spade:
        return 'spade';
      case PlayCardType.Diamond:
        return 'diamond';
      default:
        return 'heart';
    }
  }

  Widget _fetchMyType() {
    if (kIsWeb)
      return Image(
        image: AssetImage('assets/images/$filename.png'),
        color: (widget.playCard.playCardType == PlayCardType.Club || widget.playCard.playCardType == PlayCardType.Spade)
            ? Colors.black
            : Colors.red,
      );
    return SvgPicture.asset(
      'assets/images/$filename.svg',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(seconds: 2),
        decoration: BoxDecoration(
          border: Border.all(),
          color: widget.playCard.show ? Colors.white : Colors.red,
        ),
        width: CardWidget.cardWidth,
        height: CardWidget.cardHeight,
        child: widget.playCard.show
            ? Stack(
                children: <Widget>[
                  Positioned(left: 12, child: Text(widget.playCard.cardValue, style: textStyleCardValue)),
                  Positioned(top: 2, child: Container(width: 12, height: 12, child: _fetchMyType())),
                  Positioned(child: Container(child: _fetchMyType())),
                  Positioned(
                      bottom: 0,
                      right: 12,
                      child: RotatedBox(
                          quarterTurns: 2, child: Text(widget.playCard.cardValue, style: textStyleCardValue))),
                  Positioned(
                      bottom: 2,
                      right: 0,
                      child:
                          RotatedBox(quarterTurns: 2, child: Container(width: 12, height: 12, child: _fetchMyType()))),
                ],
              )
            : Container());
  }
}
