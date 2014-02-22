import 'dart:html';
import 'dart:async';
import 'dart:math' show Random;

Stopwatch mywatch = new Stopwatch();
ButtonElement button;
Timer timer;
bool readyToCount = false;
bool isCheating = false;

void main() {
  button = querySelector('#play_button')
  ..onMouseUp.listen(mouseUpEvent)
  ..onMouseOut.listen(cheat)
  ..onMouseDown.listen(mouseDownEvent);
}

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

void reset() {
  
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