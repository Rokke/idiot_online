import 'dart:math';

import 'package:flutter/material.dart';
import 'package:idiot_online/models/play_card.dart';
import 'package:idiot_online/models/player.dart';

enum GameState { nothing, create, initial, started, finished }

class Game extends ChangeNotifier {
  List<PlayCard> _cardsStock = List<PlayCard>();
  List<PlayCard> _cardsPlayed = List<PlayCard>();
  List<Player> _players = List<Player>();
  int playerMe = 0;
  bool useJoker;
  int playersTurn = 0;
  int numberOfDecs;
  GameState _gameState = GameState.nothing;
  int get numberOfCardsInStock => _cardsStock.length;
  int get numberOfCardsPlayed => _cardsPlayed.length;
  PlayCard get lastCardPlayed => _cardsPlayed.length > 0 ? _cardsPlayed.last : null;
  Player fetchPlayer(int index) => _players[index];
  bool get isStarted => _gameState == GameState.started;
  GameState get state => _gameState;
  Game({this.useJoker = true, this.numberOfDecs = 1}) {
    print('!!!Game constructor');
  }
  initializeGame() {
    _gameState = GameState.nothing;
    notifyListeners();
  }

  bool isPlayerMe(Player _player) {
    return _players.indexOf(_player) == playerMe;
  }

  startGame(List<Player> players) {
    print('startGame($players)');
    _cardsStock.clear();
    _players.clear();
    for (int decs = 0; decs < numberOfDecs; decs++) {
      for (int j = 0; j < PlayCardType.values.length; j++) {
        for (int i = 2; i < 15; i++) {
          final p = PlayCard(i, PlayCardType.values[j]);
          _cardsStock.add(p);
          print(p.toString());
        }
      }
    }
    if (useJoker) {
      _cardsStock.add(PlayCard(15, PlayCardType.Club));
      _cardsStock.add(PlayCard(15, PlayCardType.Diamond));
    }
    _gameState = GameState.initial;
    players.forEach((player) {
      _addPlayer(player);
      player.state = PlayerState.swapping;
    });
    notifyListeners();
  }

  createNewGame() {
    _gameState = GameState.create;
    print('createNewGame');
    notifyListeners();
  }

  _addPlayer(Player player) {
    print('addPlayer');
    _players.add(player);
    for (int i = 0; i < 3; i++) {
      player.cardsBottom.add(drawCardFromStock);
      player.cardsTop.add(drawCardFromStock);
      player.cardsHand.add(drawCardFromStock);
    }
  }

  PlayCard get drawCardFromStock =>
      (_cardsStock.length > 0) ? _cardsStock.removeAt(Random().nextInt(_cardsStock.length)) : null;
  List<PlayCard> get drawCardsPlayed {
    // Return the full list and clear the played cards
    if (_cardsPlayed.length > 0) {
      List<PlayCard> lst = []..addAll(_cardsPlayed);
      _cardsPlayed.clear();
      return lst;
    }
    return null;
  }

  set addCardToPlayed(PlayCard playCard) {
    print('addCardToPlayer');
    _cardsPlayed.add(playCard);
    notifyListeners();
  }

  @override
  String toString() {
    return _cardsStock.toString();
  }

  printDebugInfo() {
    print('Stock($numberOfCardsInStock): ${_cardsStock.map((e) => e.toString()).join(",")}');
    print('Played($numberOfCardsPlayed): ${_cardsPlayed.map((e) => e.toString()).join(",")}');
    _players.forEach((element) {
      element.printMyCards();
    });
  }
}
