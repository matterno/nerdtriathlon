import 'dart:html';
import 'dart:async';

InputElement inputText;
String matchString = "Dart is a new platform for scalable web app engineering!";
Stopwatch mywatch = new Stopwatch();
Timer timer;
bool gotFault = true;

void main() {
  inputText = querySelector('#inputText');
  inputText.onClick.listen(beginGame);
  inputText.onInput.listen(checkInput);
  
}

void beginGame(MouseEvent event){
  querySelector('#textImg')
      ..style.visibility = "visible";
  timer = new Timer.periodic(new Duration(milliseconds: 1), updateTime);
  mywatch.start();
}

void checkInput(Event event){
  String text = (event.target as InputElement).value;
  int textLength = text.length;
  if(textLength > 0) {
    if(matchString.codeUnitAt(textLength-1) == text.codeUnitAt(textLength-1)){
      inputText.style.backgroundColor = "white";
      if(text.length == matchString.length) {
        mywatch.stop();
        inputText.disabled = true;
      }
    } else {
      inputText.style.backgroundColor = "red";
    }
  }    
}

void updateTime(Timer _) {
  querySelector('#zeit2').text = "Zeit: "+mywatch.elapsedMilliseconds.toString()+" ms";
}