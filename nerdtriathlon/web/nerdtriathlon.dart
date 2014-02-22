import 'dart:html';
import 'dart:async';
import 'dart:math' show Random;
import '../shared/SendScore.dart';

ButtonElement sendScore;

Stopwatch mywatch = new Stopwatch();
ButtonElement button;
Timer timer;
bool readyToCount = false;
bool isCheating = false;
ButtonElement speedButton;
Stopwatch mywatch2 = new Stopwatch();
Timer timer2;
var counter = 51;

InputElement name;
InputElement inputText;
String matchString = "Dart is a new platform for scalable web app engineering!";
Stopwatch mywatch3 = new Stopwatch();
Timer timer3;
bool gotFault = true;
SendScore score;

void main() {
  button = querySelector('#play_button')
  ..onMouseUp.listen(mouseUpEvent)
  ..onMouseOut.listen(cheat)
  ..onMouseDown.listen(mouseDownEvent);
  speedButton = querySelector('#speedButton')
      ..onClick.listen(startGame);
  
  inputText = querySelector('#inputText');
  inputText.onClick.listen(beginGame);
  inputText.onInput.listen(checkInput);
  name = querySelector('#playerName')
      ..onInput.listen(setName);
  
  
  sendScore = querySelector('#sendScore')
      ..onClick.listen(sendData);
  score = new SendScore();
  
}

////////////////////////////////////////////////////////////////////////////////
void mouseUpEvent(MouseEvent event){
  if(readyToCount) {
    mywatch.stop();
    button.disabled = true;
    var time = mywatch.elapsedMilliseconds;
    querySelector('#reaktionsZeit')
    ..text = "Benoetigte Zeit: " + time.toString() + " ms";
    score.gameReaction = time;
    enableSave();
    button.text = "Fertig";
    readyToCount = false;
    isCheating = true;
  } else if(isCheating) {
    button.text = "Pressen!";
    timer.cancel();
    mywatch.stop();
    mywatch.reset();
    isCheating = false;
    readyToCount = false;
  
  }
}

void mouseDownEvent(MouseEvent event){
  isCheating = true;
  readyToCount = false;
  Random random = new Random();
  int randomTime = random.nextInt(10);
  timer = new Timer(new Duration(seconds:randomTime), go);
  button.text = "Warten..";
}

void cheat(MouseEvent event) {
  if(isCheating) {
    button.text = "Pressen!";
    timer.cancel();
    mywatch.stop();
    mywatch.reset();
    isCheating = false;
    readyToCount = false;
  }
}

void go() {
  readyToCount = true;
  mywatch.start();
  button.text = "LOSLASSEN!";
}
////////////////////////////////////////////////////////////////////////////////


void startGame(Event e){
  timer2 = new Timer.periodic(new Duration(milliseconds: 1), updateTime);
  counter--;

  if(counter == 50){
    mywatch2.start();
  }
  else if(counter ==0){
    mywatch2.stop();
    var time = mywatch2.elapsedMilliseconds;
    querySelector('#zeit').text = time.toString();
    speedButton.disabled = true;
    speedButton.text = "Fertig";
    score.gameClick = time;
    enableSave();
  }
  else{
    speedButton.text = "KLICKEN! $counter";
  }
  
 }

void updateTime(Timer _){
  querySelector('#zeit').text = "Zeit: "+mywatch2.elapsedMilliseconds.toString()+" ms";
}

////////////////////////////////////////////////////////////////////////////////


void beginGame(MouseEvent event){
  querySelector('#textImg')
      ..style.visibility = "visible";
  timer3 = new Timer.periodic(new Duration(milliseconds: 1), updateTime2);
  mywatch3.start();
}

void updateTime2(Timer _) {
  querySelector('#zeit2').text = "Zeit: "+mywatch3.elapsedMilliseconds.toString()+" ms";
}


void checkInput(Event event){
  String text = (event.target as InputElement).value;
  int textLength = text.length;
  if(textLength > 0) {
    if(matchString.codeUnitAt(textLength-1) == text.codeUnitAt(textLength-1)){
      inputText.style.backgroundColor = "white";
      if(text.length == matchString.length) {
        mywatch3.stop();
        inputText.disabled = true;
        score.gameWord = mywatch3.elapsedMilliseconds;
        enableSave();
      }
    } else {
      inputText.style.backgroundColor = "red";
    }
  }    
}

///


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
  

  request.send(score.jsonString);
  window.location.assign("http://127.0.0.1:8081/top10");
}

void setName(Event e){
  score.name = (e.target as InputElement).value;
  enableSave();
}

void enableSave() {
  if(score.name != null && score.gameReaction != 0 && score.gameClick != 0 && score.gameWord != 0) {
    sendScore.disabled = false;
  }
}
