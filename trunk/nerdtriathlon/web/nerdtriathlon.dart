import 'dart:html';
import 'dart:async';
import 'dart:math' show Random;

Stopwatch mywatch = new Stopwatch();
ButtonElement button;
Timer timer;
bool readyToCount = false;
bool isCheating = false;
ButtonElement speedButton;
Stopwatch mywatch2 = new Stopwatch();
Timer timer2;
var counter = 101;


InputElement inputText;
String matchString = "Dart is a new platform for scalable web app engineering!";
Stopwatch mywatch3 = new Stopwatch();
Timer timer3;
bool gotFault = true;

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
}

////////////////////////////////////////////////////////////////////////////////
void mouseUpEvent(MouseEvent event){
  if(readyToCount) {
    mywatch.stop();
    button.disabled = true;
    var time = mywatch.elapsedMilliseconds;
    querySelector('#reaktionsZeit')
    ..text = "Benoetigte Zeit: " + time.toString() + " ms";
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

  if(counter == 100){
    mywatch2.start();
  }
  else if(counter ==0){
    mywatch2.stop();
    var time = mywatch2.elapsedMilliseconds;
    querySelector('#zeit').text = time.toString();
    speedButton.disabled = true;
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
      }
    } else {
      inputText.style.backgroundColor = "red";
    }
  }    
}
