import 'package:finalproject/models/card.dart'; 

class Player {
  final String id;
  final String name;
  List<Card> hand;
  List<List<Card>> completedPhases;
  int currentPhase;
  int score;
  bool hasDrawn;
  bool isSkipped;
  
  Player({
    required this.id,
    required this.name,
    List<Card>? hand,
    List<List<Card>>? completedPhases,
    this.currentPhase = 1,
    this.score = 0,
    this.hasDrawn = false,
    this.isSkipped = false,
  })  : hand = hand ?? [],
        completedPhases = completedPhases ?? [];
  
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      hand: (json['hand'] as List<dynamic>).map((c) => Card.fromJson(c)).toList(),
      completedPhases: (json['completedPhases'] as List<dynamic>)
          .map((phase) => (phase as List<dynamic>)
              .map((c) => Card.fromJson(c))
              .toList())
          .toList(),
      currentPhase: json['currentPhase'],
      score: json['score'],
      hasDrawn: json['hasDrawn'],
      isSkipped: json['isSkipped'] ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hand': hand.map((c) => c.toJson()).toList(),
      'completedPhases': completedPhases
          .map((phase) => phase.map((c) => c.toJson()).toList())
          .toList(),
      'currentPhase': currentPhase,
      'score': score,
      'hasDrawn': hasDrawn,
      'isSkipped': isSkipped,
    };
  }
  
  int calculateHandScore() {
    return hand.fold(0, (sum, card) {
      if (card.type == CardType.skip) return sum + 15;
      if (card.type == CardType.wild) return sum + 25;
      return sum + card.value;
    });
  }
  
  bool hasCompletedCurrentPhase() {
    return currentPhase <= completedPhases.length;
  }
}
