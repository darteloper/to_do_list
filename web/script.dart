import 'dart:html';
import 'dart:js';

import 'utils.dart';

class Task {
  String name;
  DateTime dueDate;
  bool done = false;

  Task(this.name, this.dueDate);

  String printData(){
    return '$name - ${dueDate.day}/${dueDate.month}/${dueDate.year} - $done';
  }

}

final List list = [];

void main() {
  querySelector('#btnAdd').onClick.listen(btnAdd);
  querySelector('#btnEdit').onClick.listen(btnEdit);
  querySelector('#btnOrder').onClick.listen(btnOrder);
  querySelector('#btnDone').onClick.listen(btnDone);
  querySelector('#btnDel').onClick.listen(btnDel);
}

int getIdTask(){
  final String id = context.callMethod('prompt', ['Dijite el ID de la tarea']);
  try{
    if(int.parse(id)<=0){
      return 0;
    }
    return int.parse(id);
  }catch(e){
    return 0;
  }
}

bool getIsDone(){
  final String isDone = context.callMethod('prompt', ['Dijite 1 para true, cualquier otro valor para false']);
  if(isDone == '1'){
    return true;
  }
  return false;
}

Task createTask(){
  final String task = context.callMethod('prompt', ['Escriba el titulo de la tarea']);
  final String dueDate = context.callMethod('prompt', ['Dijite la fecha YYYY-MM-DD']);
  return Task(task,DateTime.parse(dueDate));
}

void processCreateTask(){
  list.add(createTask());
  printList();
}

void processEditTask(){
  final id = getIdTask();
  if(id == 0 || id > list.length){
    context.callMethod('alert',['Número no valido']);
  }

  var task = createTask();
  list[id-1] = task;
  printList();
}

void processOrderTask(){

}

void processDoneTask(){
  final id = getIdTask();
  if(id == 0 || id > list.length){
    context.callMethod('alert',['Número no valido']);
  }
  final isDone = getIsDone();
  Task task = list[id-1];
  task.done = isDone;
  printList();
}

void processDeleteTask(){
  var id = getIdTask();
  if(id == 0 || id > list.length){
    context.callMethod('alert',['Número no valido']);
  }
  list.removeAt(id-1);
  printList();
}

void btnAdd(MouseEvent event){
  processCreateTask();
}

void btnEdit(MouseEvent event){
  processEditTask();
}

void btnOrder(MouseEvent event){
  for(var i=0;i<list.length;i++){
    for(var j=0;j<list.length;j++){
      Task taskI = list[i];
      Task taskJ = list[j];
      if(taskJ.dueDate.isAfter(taskI.dueDate)){
        var taskAux = taskI;
        list[i] = taskJ;
        list[j] = taskAux;
      }
    }
  }
  printList();
}

void btnDone(MouseEvent event){
  processDoneTask();
}

void btnDel(MouseEvent event){
  processDeleteTask();
}