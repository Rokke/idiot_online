import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idiot_online/models/constants.dart';
import 'package:idiot_online/models/play_card.dart';

class CardWidget extends StatefulWidget {
  static const double cardWidth = 80;
  static const double cardHeight = 120;
  final PlayCard playCard;
  final bool showCard;
  final double sizeFactor;
  CardWidget(this.playCard, {this.showCard = false, this.sizeFactor = 1, Key key}) : super(key: key);

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
//    print('CardWidget build(${widget.playCard}');
    return AnimatedContainer(
        duration: Duration(seconds: 2),
        decoration: BoxDecoration(
          border: Border.all(),
          color: widget.playCard.show || widget.showCard ? Colors.white : Colors.red,
        ),
        width: CardWidget.cardWidth * widget.sizeFactor,
        height: CardWidget.cardHeight * widget.sizeFactor,
        child: widget.playCard.show || widget.showCard
            ? Stack(
                children: <Widget>[
                  Positioned(
                      left: 12 * widget.sizeFactor,
                      child: Text(widget.playCard.cardValue,
                          style:
                              textStyleCardValue.copyWith(fontSize: textStyleCardValue.fontSize * widget.sizeFactor))),
                  Positioned(
                      top: 2,
                      child: Container(
                          width: 12 * widget.sizeFactor, height: 12 * widget.sizeFactor, child: _fetchMyType())),
                  Positioned(child: Container(child: _fetchMyType())),
                  Positioned(
                      bottom: 0,
                      right: 12 * widget.sizeFactor,
                      child: RotatedBox(
                          quarterTurns: 2,
                          child: Text(widget.playCard.cardValue,
                              style: textStyleCardValue.copyWith(
                                  fontSize: textStyleCardValue.fontSize * widget.sizeFactor)))),
                  Positioned(
                      bottom: 2,
                      right: 0,
                      child: RotatedBox(
                          quarterTurns: 2,
                          child: Container(
                              width: 12 * widget.sizeFactor, height: 12 * widget.sizeFactor, child: _fetchMyType()))),
                ],
              )
            : Container());
  }
}
