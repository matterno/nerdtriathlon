import 'dart:html';
import 'dart:async';

Stopwatch mywatch = new Stopwatch();
ButtonElement button;
Timer timer;

void main() {
  button = querySelector('#play_button')
  ..onMouseUp.listen(mouseUpEvent);
  timer = new Timer(new Duration(seconds:5), go);
}

void mouseUpEvent(MouseEvent event){
  mywatch.stop();
  var time = mywatch.elapsedMilliseconds;
  button.text = time.toString();
  button.disabled = true;
}

void reset() {
  
}
void go() {
  mywatch.start();
  button.text = "LOSLASSEN!";
}