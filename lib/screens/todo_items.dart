import 'package:flutter/material.dart';
import 'package:to_do_app/todo.dart';
import 'package:to_do_app/screens/home.dart';
class TodoItem extends StatelessWidget {
  final Todo todo;
  final onToDoChange;
  final onDeleteItem;
  const TodoItem({super.key, required this.todo, required this.onToDoChange, required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTap: (){
          print("Clicked on ToDo Item tile");
          onToDoChange(todo);
          print(todo.isDone);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone?Icons.check_box_sharp:Icons.check_box_outline_blank_outlined,
          color: Colors.lightBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            decoration: todo.isDone?TextDecoration.lineThrough:null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.red,
          ),
          child: IconButton(
            onPressed: (){
              onDeleteItem(todo.id);
              print("Clicked on delete item button");
            },
            icon: Icon(Icons.delete),
            color: Colors.white,
            iconSize: 18,
          ),
        ),
      ),
    );
  }
}
