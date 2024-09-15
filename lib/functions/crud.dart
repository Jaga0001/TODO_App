import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/todoModel.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Add a new todo
Future<void> addTodo(Todo todo) async {
  await _firestore.collection('todos').add({
    'title': todo.title,
    'isDone': todo.isDone,
  });
}

// Update a todo
Future<void> updateTodo(Todo todo) async {
  await _firestore.collection('todos').doc(todo.id).update({
    'isDone': todo.isDone,
  });
}

// Get todos stream
Stream<List<Todo>> getTodos() {
  return _firestore.collection('todos').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return Todo(
        id: doc.id, // Use document ID as Todo ID
        title: doc['title'],
        isDone: doc['isDone'],
      );
    }).toList();
  });
}

Future<void> deleteTodo(String id) async {
  try {
    await FirebaseFirestore.instance.collection('todos').doc(id).delete();
  } catch (e) {
    print('Error deleting TODO: $e');
  }
}

Future<void> updateNameTodo(String name, Todo todo) async {
  try {
    await _firestore.collection('todos').doc(todo.id).update({'title': name});
  } catch (e) {
    print(e.toString());
  }
}
