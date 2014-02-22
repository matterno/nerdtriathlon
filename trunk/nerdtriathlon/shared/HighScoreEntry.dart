import 'dart:convert' show JSON;

class HighScoreEntry implements Comparable<HighScoreEntry>{
  
  HighScoreEntry() { }
  
  String name;
  int score;
  int scoreReaction;
  int scoreWord;
  int scoreClick;
  
  HighScoreEntry.fromJSON(String json) {
    Map entry = JSON.decode(json);
    name = entry['name'];
    score = entry['score'];
    scoreReaction = entry['gameReaction'];
    scoreWord = entry['gameWord'];
    scoreClick = entry['gameClick'];
  }
  
  String get jsonString => JSON.encode({"name": name, "score": score, "scoreReaction": scoreReaction, "scoreWord": scoreWord, "scoreClick": scoreClick});

  int compareTo(HighScoreEntry other) {
    return score.compareTo(other.score);
  }
}