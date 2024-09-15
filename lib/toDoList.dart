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
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        title: Center(
          child: Text(
            'TO DO',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
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
                  endActionPane: ActionPane(motion: StretchMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        deleteTodo(todo.id);
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        _showUpdateDialog(context, todo.id);
                      },
                      backgroundColor: Colors.white,
                      icon: Icons.update,
                      label: 'Update',
                    )
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue.shade300),
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: TextStyle(color: Colors.black),
                        ),
                        leading: Checkbox(
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

  Future _showUpdateDialog(context, id) {
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
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    if (_updateController.text.isNotEmpty) {
                      updateNameTodo(_updateController.text, id);
                      _updateController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Update')),
            ],
          );
        });
  }
}
