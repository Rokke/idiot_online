import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idiot_online/models/constants.dart';
import 'package:idiot_online/models/play_card.dart';

class CardWidget extends StatefulWidget {
  static const double cardWidth = 80;
  static const double cardHeight = 120;
  final PlayCard playCard;
  final Function onTap;
  final bool showCard;
  final double sizeFactor;
  CardWidget(this.playCard, this.showCard, {this.sizeFactor = 1, this.onTap, Key key}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  double get cardWidth => CardWidget.cardWidth * widget.sizeFactor;
  double get cardHeight => CardWidget.cardHeight * widget.sizeFactor;
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
        image: AssetImage('images/$filename.png'),
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
    Row _textAndType = Row(mainAxisSize: MainAxisSize.min, children: [
      ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 12 * widget.sizeFactor, height: 12 * widget.sizeFactor),
          child: _fetchMyType()),
      Text(widget.playCard.cardValue,
          style: textStyleCardValue.copyWith(fontSize: textStyleCardValue.fontSize * widget.sizeFactor))
    ]);
//    if (widget.onTap != null) widget.onTap(widget.playCard);
    return GestureDetector(
      onTap: () => widget.onTap != null ? widget.onTap() : null,
      child: AnimatedContainer(
          duration: Duration(seconds: 1),
          decoration: BoxDecoration(
            border: Border.all(),
            color: widget.showCard ? Colors.white : Colors.red,
          ),
          width: cardWidth,
          height: cardHeight,
          child: widget.showCard
              ? Stack(
                  children: <Widget>[
                    Positioned(left: 2, child: _textAndType),
                    Positioned(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(child: _fetchMyType()))),
                    Positioned(
                        bottom: 0,
                        right: 2 * widget.sizeFactor,
                        child: RotatedBox(quarterTurns: 2, child: _textAndType)),
                  ],
                )
              : Container()),
    );
  }
}
