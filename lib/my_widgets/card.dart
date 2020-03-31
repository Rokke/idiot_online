import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idiot_online/models/card.dart';

class CardWidget extends StatefulWidget {
  final PlayCard playCard;
  CardWidget(this.playCard, {Key key}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget _fetchMyType() {
    return SvgPicture.asset(
      'assets/images/spade.svg',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.playCard.show ? Colors.white : Colors.red,
        width: 80,
        height: 120,
        child: widget.playCard.show
            ? Stack(
                children: <Widget>[
                  Positioned(left: 10, child: Text(widget.playCard.cardValue)),
                  Positioned(top: 2, child: Container(width: 12, height: 12, child: _fetchMyType())),
                  Positioned(child: Container(child: _fetchMyType())),
                  Positioned(
                      bottom: 0, right: 10, child: RotatedBox(quarterTurns: 2, child: Text(widget.playCard.cardValue))),
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
