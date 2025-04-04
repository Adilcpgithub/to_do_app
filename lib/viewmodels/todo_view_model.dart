import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/services/firebase_service.dart';

class TodoViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Todo> _todos = [];
  bool _isLoading = false;
  String? _error;
  List<Todo> get dotos => _todos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  //! Load Todos
  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _todos = await _firebaseService.fetchTodos();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  //! Add Todo
  Future<void> addTodo(Todo todo) async {
    await _firebaseService.addTodo(todo);
    await loadTodos();
  }

  //! Delete Todo
  Future<void> deleteTodo(String id) async {
    await _firebaseService.deteteTodo(id);
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  //! Update Todo
  Future<void> updateTodo(Todo todo) async {
    await _firebaseService.updateTodo(todo);
    await loadTodos();
  }

  //!  Toggle Completion
  Future<void> toggleCompleted(Todo todo) async {
    final updated = todo..isCompleted = !todo.isCompleted;
    await _firebaseService.toggleCompleted(updated.id, updated.isCompleted);
    await loadTodos();
  }
}
