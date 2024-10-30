import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class ApiService {
  final String baseUrl = 'https://dummyjson.com/todos';

  Future<TodoResponse> fetchTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return TodoResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Échec du chargement des tâches');
    }
  }

  Future<Todo> addTodo(String todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'todo': todo, 'completed': false, 'userId': 1}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Échec de l\'ajout de la tâche');
    }
  }
}
