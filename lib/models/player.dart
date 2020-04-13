import 'package:flutter/material.dart';
import 'package:idiot_online/models/play_card.dart';

class Player {
  String name;
  Color color;
  final List<PlayCard> cardsHand = List<PlayCard>();
  final List<PlayCard> cardsTop = List<PlayCard>();
  final List<PlayCard> cardsBottom = List<PlayCard>();
  Player(this.name, {this.color = Colors.blue});
  printMyCards() {
    print('Player: $name, $color');
    print('Bottom: ${cardsBottom.map((e) => e.toString()).join(",")}');
    print('Top: ${cardsTop.map((e) => e.toString()).join(",")}');
    print('Hand: ${cardsHand.map((e) => e.toString()).join(",")}');
  }

  set drawCard(PlayCard playCard) => cardsHand.add(playCard);
  set drawCardList(List<PlayCard> playCard) => cardsHand.addAll(playCard);
  int get numberOfCardsOnHand => cardsHand.length;
  factory Player.createDefault() => Player("");
}
