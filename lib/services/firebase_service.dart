import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/models/todo.dart';

class FirebaseService {
  final CollectionReference todosCollection = FirebaseFirestore.instance
      .collection('todos');

  //!Fetch all todos, and set Firestore document ID as `id`
  Future<List<Todo>> fetchTodos() async {
    try {
      final snapshot = await todosCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Todo.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch todos: $e');
    }
  }

  //! Add a new Todo
  Future<void> addTodo(Todo todo) async {
    await todosCollection.add(todo.toJson());
  }

  //! Delete Todo
  Future<void> deteteTodo(String id) async {
    await todosCollection.doc(id).delete();
  }

  //! Update Todo (title, description, dueDate, isCompleted)

  Future<void> updateTodo(Todo todo) async {
    await todosCollection.doc(todo.id).update(todo.toJson());
  }

  //! Toggle isCompleted
  Future<void> toggleCompleted(String id, bool value) async {
    await todosCollection.doc(id).update({'isCompleted': value});
  }
}
