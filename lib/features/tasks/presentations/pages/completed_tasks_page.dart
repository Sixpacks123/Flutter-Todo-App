import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/task_provider.dart';
import '../widgets/task_card.dart';

class CompletedTasksPage extends ConsumerWidget {
  const CompletedTasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskListProvider);
    final completedTasks = taskState.todos.where((task) => task.completed).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: completedTasks.isEmpty
          ? const Center(
        child: Text(
          'Aucune tâche terminée',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      )
          : ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          return TaskCard(
            todo: completedTasks[index],
            onToggleComplete: () {
              ref
                  .read(taskListProvider.notifier)
                  .toggleTodoCompletion(completedTasks[index]);
            },
          );
        },
      ),
    );
  }
}
