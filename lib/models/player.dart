import 'package:idiot_online/models/play_card.dart';

class Player {
  final String name;
  final List<PlayCard> cardsHand = List<PlayCard>();
  final List<PlayCard> cardsTop = List<PlayCard>();
  final List<PlayCard> cardsBottom = List<PlayCard>();
  Player(this.name);
  printMyCards() {
    print('Bottom: ${cardsBottom.map((e) => e.toString()).join(",")}');
    print('Top: ${cardsTop.map((e) => e.toString()).join(",")}');
    print('Hand: ${cardsHand.map((e) => e.toString()).join(",")}');
  }
}
