import 'package:flutter/material.dart';

import '../../domains/models/todo_model.dart';

class TaskCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggleComplete;

  const TaskCard({
    required this.todo,
    required this.onToggleComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.grey[200],
      elevation: 2.0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        title: Text(
          todo.todo,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            decoration: todo.completed ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Icon(
          todo.completed ? Icons.check_box : Icons.check_box_outline_blank,
          color: todo.completed ? Colors.green : Colors.grey,
        ),
        onTap: onToggleComplete,
      ),
    );
  }
}
