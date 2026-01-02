enum CardColor { heart, diamond, club, spade }

class GameCard {
  final String name;
  final CardColor color;
  final int points;

  GameCard(this.name, this.color, this.points);

  String get colorName {
    switch (color) {
      case CardColor.heart:
        return '❤️';
      case CardColor.diamond:
        return '♦️';
      case CardColor.club:
        return '♣️';
      case CardColor.spade:
        return '♠️';
    }
  }
}
