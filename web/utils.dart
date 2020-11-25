import 'dart:html';
import 'script.dart';

void printList() {
  var listTask = querySelector('#list');
  listTask.innerHtml = '';
  for (Task task in list) {
    var newToDo = LIElement();
    newToDo.text = '${task.printData()}';
    listTask.children.add(newToDo);
  }
}
