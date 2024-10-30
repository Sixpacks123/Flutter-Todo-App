import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domains/api_service.dart';
import '../../domains/todo_model.dart';

final taskListProvider = StateNotifierProvider<TaskListNotifier, TaskState>((ref) {
  return TaskListNotifier();
});

class TaskState {
  final List<Todo> todos;
  final bool isLoading;
  final String? error;

  TaskState({
    required this.todos,
    this.isLoading = false,
    this.error,
  });
}

class TaskListNotifier extends StateNotifier<TaskState> {
  TaskListNotifier() : super(TaskState(todos: [], isLoading: true)) {
    fetchTodos();
  }

  final ApiService _apiService = ApiService();

  // Récupération des tâches
  Future<void> fetchTodos() async {
    try {
      final todoResponse = await _apiService.fetchTodos();
      state = TaskState(todos: todoResponse.todos);
    } catch (e) {
      state = TaskState(todos: [], error: 'Erreur lors du chargement des tâches : $e');
    }
  }

  Future<void> addTodo(String todo) async {
    try {
      final newTodo = await _apiService.addTodo(todo);
      state = TaskState(todos: [...state.todos, newTodo]);
    } catch (e) {
      print('Erreur lors de l\'ajout de la tâche : $e');
    }
  }

  void toggleTodoCompletion(Todo todo) {
    final updatedTodo = todo.copyWith(completed: !todo.completed);
    state = TaskState(todos: [
      for (final t in state.todos)
        if (t.id == todo.id) updatedTodo else t
    ]);
  }
}
