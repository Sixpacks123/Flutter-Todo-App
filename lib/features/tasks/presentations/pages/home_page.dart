import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/task_provider.dart';
import '../widgets/AddTaskBottomSheet.dart';
import '../widgets/task_card.dart';
import '../widgets/stat_box.dart';
import 'completed_tasks_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  Widget _buildPageContent() {
    final taskState = ref.watch(taskListProvider);
    final activeTasks = taskState.todos.where((task) => !task.completed).toList();

    if (_selectedIndex == 0) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatBox(
                  title: 'Total',
                  count: taskState.todos.length,
                  color: Colors.black,
                ),
                StatBox(
                  title: 'Actives',
                  count: activeTasks.length,
                  color: Colors.black,
                ),
                StatBox(
                  title: 'Terminés',
                  count: taskState.todos.length - activeTasks.length,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: activeTasks.isEmpty
                  ? const Center(
                child: Text(
                  'Aucune tâche active disponible',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: activeTasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    todo: activeTasks[index],
                    onToggleComplete: () {
                      ref
                          .read(taskListProvider.notifier)
                          .toggleTodoCompletion(activeTasks[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else if (_selectedIndex == 1) {
      return const CompletedTasksPage();
    } else {
      return const Center(child: Text('Page non trouvée'));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _openAddTaskBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddTaskBottomSheet(),
    );

    if (result != null && result.isNotEmpty) {
      ref.read(taskListProvider.notifier).addTodo(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text(
          'Flutter Todo List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: _buildPageContent(),
      bottomNavigationBar: BottomNavigationBar(

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Terminées',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        backgroundColor: Colors.grey[100],

        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0 || _selectedIndex == 1
          ? FloatingActionButton(
        onPressed: () => _openAddTaskBottomSheet(context),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
