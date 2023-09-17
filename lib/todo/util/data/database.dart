import 'package:hive_flutter/hive_flutter.dart';

class  TodoDatabase{
List  todolist = [];

  final _myBox = Hive.box('myBox');

  void createinitialData(){
    todolist = [
      ["Submit EC304 Assignment",false]
    ];
  }
    //load the data from database

   void loadData(){
      todolist =_myBox.get("TODO");
    } 

    void uPDATEData(){
      _myBox.put("TODO",todolist);
    }
}
