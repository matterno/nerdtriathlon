import 'dart:html';
import 'dart:async';

InputElement inputText;
String example = "Am zehnten zehnten zehn Uhr zehn zogen zehn zahme Ziegen zehn Zentner Zucker zum Zoo.";
Stopwatch mywatch = new Stopwatch();
Timer timer;

void main() {
  inputText = querySelector('#inputText');
  inputText.onClick.listen(beginGame);
}

void beginGame(MouseEvent event){
  
}