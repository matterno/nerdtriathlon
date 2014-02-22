import 'dart:html';
import 'dart:async';

ButtonElement speedButton;
Stopwatch mywatch = new Stopwatch();
Timer timer;
var counter = 101;

void main() {
 
  speedButton = querySelector('#speedButton')
      ..onClick.listen(startGame);
  
}

void startGame(Event e){
  timer = new Timer.periodic(new Duration(milliseconds: 1), updateTime);
  counter--;

  if(counter == 100){
    mywatch.start();
  }
  else if(counter ==0){
    mywatch.stop();
    var time = mywatch.elapsedMilliseconds;
    querySelector('#zeit').text = time.toString();
    speedButton.disabled = true;
  }
  else{
    speedButton.text = "KLICKEN! $counter";
  }
  
 }

void updateTime(Timer _){
  querySelector('#zeit').text = "Zeit: "+mywatch.elapsedMilliseconds.toString()+" ms";
}

