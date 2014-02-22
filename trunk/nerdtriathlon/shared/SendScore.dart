import 'dart:convert' show JSON;

class SendScore {
  
  SendScore() { }
  
  String name;
  int gameReaction;
  int gameWord;
  int gameClick;
  
  SendScore.fromJSON(String json) {
    Map score = JSON.decode(json);
    name = score['name'];
    gameReaction = score['gameReaction'];
    gameWord = score['gameWord'];
    gameClick = score['gameClick'];
  }
  
  String get jsonString => JSON.encode({"name": name, "gameReaction": gameReaction, "gameWord": gameWord, "gameClick": gameClick});
  
}