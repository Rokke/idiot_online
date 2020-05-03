import 'package:flutter/material.dart';
import 'package:idiot_online/models/play_card.dart';

enum PlayerState { initial, swapping, ready, myTurn, finished }

class Player {
  String name;
  Color color;
  PlayerState state = PlayerState.initial;
  final List<PlayCard> cardsHand = List<PlayCard>();
  final List<PlayCard> cardsTop = List<PlayCard>();
  final List<PlayCard> cardsBottom = List<PlayCard>();
  List<PlayCard> get cardOnTable {
    List<PlayCard> newList = List<PlayCard>();
    for (int i = 0; i < 3; i++) {
      newList.add(cardsTop[i] ?? cardsBottom[i]);
    }
    return newList;
  }

  Player(this.name, {this.color = Colors.blue});
  printMyCards() {
    print('Player: $name, $color');
    print('Bottom: ${cardsBottom.map((e) => e.toString()).join(",")}');
    print('Top: ${cardsTop.map((e) => e.toString()).join(",")}');
    print('Hand: ${cardsHand.map((e) => e.toString()).join(",")}');
  }

  bool shouldShowCardOnTable(int index) {
    return cardsTop[index] != null;
  }

  set drawCard(PlayCard playCard) => cardsHand.add(playCard);
  set drawCardList(List<PlayCard> playCard) => cardsHand.addAll(playCard);
  bool drawFromCardOnTable(int index) {
    if (cardsTop[index] != null) {
      cardsHand.add(cardsTop[index]);
      cardsTop[index] = null;
    } else
      return false;
    return true;
  }

  bool drawFromHandToTable(int index) {
    for (int i = 0; i < 3; i++) {
      if (cardsTop[i] == null) {
        cardsTop[i] = cardsHand.removeAt(index);
        return true;
      }
    }
    return false;
  }

  PlayCard playCard(int index) {
    state = PlayerState.ready;
    return cardsHand.removeAt(index);
  }

  @override
  String toString() {
    return '$name, $color, $state';
  }

  int get numberOfCardsOnHand => cardsHand.length;
  factory Player.createDefault() => Player("");
}
