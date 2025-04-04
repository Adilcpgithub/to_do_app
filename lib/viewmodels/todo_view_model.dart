import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/services/firebase_service.dart';

class TodoViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Todo> _todos = [];
  bool _isLoading = false;
  String? _error;
  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get todosCount => _todos.length.toString();
  String pendingTodos() {
    int count = 0;
    for (var i in _todos) {
      if (i.isCompleted == false) {
        count++;
      }
    }
    return count.toString();
  }

  String completedTodos() {
    return (todos.length - int.parse(pendingTodos())).toString();
  }

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
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = Todo(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        dueDate: todo.dueDate,
        isCompleted: !todo.isCompleted,
      );
      notifyListeners();
      await _firebaseService.toggleCompleted(
        _todos[index].id,
        _todos[index].isCompleted,
      );
    }
  }
}
