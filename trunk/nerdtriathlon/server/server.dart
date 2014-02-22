import 'dart:convert' show JSON;
import 'dart:io';
import '../shared/SendScore.dart';
import '../shared/HighScoreEntry.dart';

List<HighScoreEntry> highscore = [];

void main() {
  HttpServer.bind('127.0.0.1', 8081)
    .then((server) {
      gotMessage(server);
    });
}

gotMessage(HttpServer _server) {
  _server.listen((HttpRequest request) {    
    if(request.uri.path == '/submit') {
      handleSubmit(request);
    } else if(request.uri.path == '/top10') {
      handleHighscore(request);
    }
  });
}

handleHighscore(HttpRequest request) {
  HttpResponse response = request.response;
  
  addCorsHeaders(response);
  
  if(request.method == "GET") {
    print('Received highscore request');
    
    List <String> entriesString = getTop10Highscore();
    
    response.write(JSON.encode(entriesString));
    response.close();
  }
}

handleSubmit(HttpRequest request) {
  addCorsHeaders(request.response);
  
  if(request.method == "POST") {
    List<int> dataBody = new List<int>();
    request.listen(dataBody.addAll, onDone: () {
      String postData = new String.fromCharCodes(dataBody);
      
      print('Received POST request:');
      print('${postData}');
      
      SendScore score = new SendScore.fromJSON(postData);
      
      print('Parsed data: name = ${score.name}, reaction = ${score.gameReaction}, click = ${score.gameClick}, word = ${score.gameWord}');
      
      HighScoreEntry highscoreEntry = new HighScoreEntry();
      highscoreEntry..name = score.name
          ..score = calculateScore(score)
          ..scoreClick = score.gameClick
          ..scoreReaction = score.gameReaction
          ..scoreWord = score.gameWord;
      
      highscore.add(highscoreEntry);
      
      // Do something with the data now.
      request.response.write("SUCCESS");
    });
  } else {
    request.response.write("ERROR");
  }
  
  request.response.close();
}

int calculateScore(SendScore score) {
  return score.gameClick*2 + score.gameReaction*30 + score.gameWord;
}

void addCorsHeaders(HttpResponse res) {
  res.headers.add('Access-Control-Allow-Origin', '*, ');
  res.headers.add('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.headers.add('Access-Control-Allow-Headers',
      'Origin, X-Requested-With, Content-Type, Accept');
}

List<String> getTop10Highscore() {
  highscore.sort((a, b) => a.compareTo(b));

  int end = 0;
  
  if(highscore.length >= 10) {
    end = 10;
  } else {
    end = highscore.length;
  }
  
  List<String> entries = new List<String>();
  for(int i = 0; i < end; i++) {
    entries.add(highscore[i].jsonString);
  }
  
  return entries;
}