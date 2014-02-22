import 'dart:html';
import 'dart:async';

ButtonElement sendScore;

void main() {
 
  sendScore = querySelector('#sendScore')
      ..onClick.listen(sendData);
}

void sendData(Event e) {
  
}
