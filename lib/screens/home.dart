import 'package:flutter/material.dart';
import 'package:to_do_app/screens/todo_items.dart';
import '/todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final toDoList = Todo.todoList();
  List<Todo> foundToDo = [];
  final toDoController = TextEditingController();

  @override
  void initState() {
    foundToDo = toDoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          "ALL TASKS",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      for ( Todo todo in foundToDo.reversed )
                        TodoItem(
                          todo: todo,
                          onToDoChange: handleToDoChange,
                          onDeleteItem: deleteToDo,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20,left: 20),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: toDoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new ToDo Item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom:20, right: 20),
                  // padding: EdgeInsets.all(0),
                  child: ElevatedButton(
                    onPressed: (){
                      if(!toDoController.text.isEmpty)
                        addItem(toDoController.text);
                    },
                    // child: Icon(Icons.add),
                    child: Text('+', style: TextStyle(fontSize: 40),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      minimumSize:Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addItem(String toDo){
    setState(() {
    toDoList.add(
        Todo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: toDo
        ),
    );
    });
    toDoController.clear();
  }

  void deleteToDo(String id){
    setState(() {
      toDoList.removeWhere((item) => item.id == id);
    });
  }

  void handleToDoChange(Todo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void filterToDo(String keyword){
    List<Todo> results = [];
    if(keyword.isEmpty){
      results = toDoList;
    }else{
      results = toDoList
          .where((item) => item.todoText!
          .toLowerCase()
          .contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundToDo = results;
    });

  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => filterToDo(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: Colors.black,size: 20,),
            constraints: BoxConstraints(
              maxHeight: 35,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey)
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey[100],
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Icon(
            Icons.menu,
            color: Colors.black,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar_man.png'),
            ),
          ),
        ],
      ),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
