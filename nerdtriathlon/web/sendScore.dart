import 'dart:html';
import 'dart:async';
import '../shared/SendScore.dart';

ButtonElement sendScore;

void main() {
 
  sendScore = querySelector('#sendScore')
      ..onClick.listen(sendData);
}

void sendData(Event e) {
  HttpRequest request = new HttpRequest(); // create a new XHR
  // add an event handler that is called when the request finishes
  request.onReadyStateChange.listen((_) 
      {
    if (request.readyState == HttpRequest.DONE &&
        (request.status == 200 || request.status == 0)) {
      // data saved OK.
      print(request.responseText); // output the response from the server
    }
      }
  );
  
  var url = "http://127.0.0.1:8081/submit";
  request.open("POST", url, async: false);
  request.setRequestHeader("Content-Type", "application/json");
  
  SendScore score = new SendScore();
  score..name = "test"
      ..gameClick = 400
      ..gameReaction = 200
      ..gameWord = 300;
  request.send(score.jsonString);
}
