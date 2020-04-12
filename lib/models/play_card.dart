enum PlayCardType { Spade, Heart, Diamond, Club }

class PlayCard {
  final int value;
  final PlayCardType playCardType;
  bool show;
  String get cardValue {
    switch (value) {
      case 14:
        return "A";
      case 13:
        return "K";
      case 12:
        return "D";
      case 11:
        return "Kn";
      case 15:
        return "J";
      default:
        return value.toString();
    }
  }

  PlayCard(this.value, this.playCardType, {this.show = false});
  @override
  String toString() {
    return "$cardValue - ${playCardType.toString().split(".").last}(${show ? '+' : '-'})";
  }
}
