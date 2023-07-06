class Todo {
  String? id;
  String? todoText;
  late bool isDone;

  Todo({
   required this.id,
   required this.todoText,
   this.isDone = false,
  });

  static List<Todo> todoList() {
    return[
      // Todo(id:'01', todoText: 'Buy Groceries', isDone: true),
      // Todo(id: '02', todoText: 'Buy pencil', isDone: true),
      // Todo(id: '03', todoText: 'clear out the house', isDone: false),
    ];
  }

}