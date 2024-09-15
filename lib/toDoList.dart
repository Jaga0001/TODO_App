import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/functions/crud.dart';
import 'package:todoapp/todoModel.dart';

class ToDoListScreen extends StatefulWidget {
  ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final TextEditingController _addController =
      TextEditingController(); // Controller to capture user input

  final TextEditingController _updateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<Todo>>(
          stream: getTodos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No Data'));
            }

            final todos = snapshot.data!;

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Slidable(
                  key: ValueKey(todo.id),
                  endActionPane: ActionPane(motion: ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        deleteTodo(todo.id);
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Colors.white,
                      icon: Icons.update,
                      label: 'Update',
                    )
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.yellow.shade300),
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Checkbox(
                          value: todo.isDone,
                          onChanged: (bool? value) {
                            setState(() {
                              todo.isDone = value ?? false;
                            });
                            updateTodo(
                                todo); // Updates the task's status in Firestore
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  Future _showAddDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add New TODO'),
            content: TextField(
              controller: _addController, // Capture input from user
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'Enter TODO'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_addController.text.isNotEmpty) {
                      final newTodo = Todo(
                        id: DateTime.now().toString(), // Use timestamp as ID
                        title: _addController.text,
                        isDone: false,
                      );
                      addTodo(newTodo); // Add new task to Firestore
                      _addController.clear(); // Clear input field
                      Navigator.pop(context); // Close the dialog
                    }
                  },
                  child: Text('Add')),
              TextButton(
                  onPressed: () {
                    _addController.clear(); // Clear the input when canceled
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }

  Future _showUpdateDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update TODO'),
            content: TextField(
              controller: _updateController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'TODO'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _updateController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }
}
