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
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  //! DateTime Variables  functions
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  void selectDate(DateTime pickedDate) {
    _selectedDate = pickedDate;
    notifyListeners();
  }

  //! Time varibles and functions
  TimeOfDay? _selectedTime;
  TimeOfDay? get selectedTime => _selectedTime;
  void selectTime(TimeOfDay pickedTime) {
    _selectedTime = pickedTime;
    notifyListeners();
  }

  //! Clear Time and Date Fields
  void clearDateAndTime() {
    _selectedDate = null;
    _selectedTime = null;
  }

  //! Fetching search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Todo> get filteredTodos {
    if (_searchQuery.isEmpty) return _todos;
    return _todos
        .where(
          (todo) =>
              todo.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  //! Total Todos count
  String get todosCount => _todos.length.toString();

  // ! Pending  Todos Count
  String pendingTodos() {
    int count = 0;
    for (var i in _todos) {
      if (i.isCompleted == false) {
        count++;
      }
    }
    return count.toString();
  }

  // ! completed Todos Count
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
