import '../models/game_card.dart';
import 'dart:math';

class GameEngine {
  final int players;
  int teamAPoints = 0;
  int teamBPoints = 0;

  List<List<GameCard>> hands = [];

  GameEngine(this.players) {
    _dealCards();
  }

  List<GameCard> _createDeck() {
    final names = ['A','K','Q','J','10','9','8','7','3'];
    List<GameCard> deck = [];

    for (var c in CardColor.values) {
      for (var n in names) {
        deck.add(GameCard(n, c, _points(n)));
      }
    }
    deck.shuffle(Random());
    return deck;
  }

  int _points(String name) {
    if (name == 'J') return 3;
    if (name == '9') return 2;
    if (name == 'A' || name == '10') return 1;
    if (players == 6 && name == '3') return 3;
    return 0;
  }

  void _dealCards() {
    int count = players == 4 ? 4 : players == 6 ? 3 : 2;
    var deck = _createDeck();

    hands = List.generate(players, (_) => []);
    for (int i = 0; i < players * count; i++) {
      hands[i % players].add(deck.removeLast());
    }
  }

  void illegalPlay() {
    teamBPoints += 4;
  }

  void messaSuccess(int value) {
    if (value <= 29) {
      teamAPoints += 1;
    } else {
      teamAPoints += 2;
    }
  }

  void messaFail(int value) {
    if (value <= 29) {
      teamBPoints += 2;
    } else {
      teamBPoints += 3;
    }
  }

  bool isGameOver() => teamAPoints >= 15 || teamBPoints >= 15;
}
