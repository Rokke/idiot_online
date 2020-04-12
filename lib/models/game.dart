import 'dart:math';

import 'package:flutter/material.dart';
import 'package:idiot_online/models/play_card.dart';

class Game extends ChangeNotifier {
  List<PlayCard> _cards = List<PlayCard>();
  bool useJoker;
  int numberOfDecs;
  int get numberOfCardsInStock => _cards.length;
  Game({this.useJoker = true, this.numberOfDecs = 1}) {
    for (int decs = 0; decs < numberOfDecs; decs++) {
      for (int j = 0; j < PlayCardType.values.length; j++) {
        for (int i = 1; i < 14; i++) {
          final p = PlayCard(i, PlayCardType.values[j]);
          _cards.add(p);
          print(p.toString());
        }
      }
    }
    if (useJoker) {
      _cards.add(PlayCard(15, PlayCardType.Club));
      _cards.add(PlayCard(15, PlayCardType.Diamond));
    }
    print('ferdig');
    notifyListeners();
  }
  PlayCard get drawCard => (_cards.length > 0) ? _cards.removeAt(Random().nextInt(_cards.length)) : null;
  @override
  String toString() {
    return _cards.toString();
  }
}
