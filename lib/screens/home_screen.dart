import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _future = Supabase.instance.client.from('todo').select();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final bool isDone = task['isDone'] == 1;
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    task['title'],
                    style: TextStyle(
                      decoration: isDone ? TextDecoration.lineThrough : null,
                      color: isDone ? Colors.grey : Colors.black87,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteTask(task['id']);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          isDone ? Icons.undo : Icons.check,
                          color: isDone ? Colors.grey : Colors.green,
                        ),
                        onPressed: () {
                          _toggleTaskDone(task['id'], !isDone);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить задачу'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Название задачи'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите название задачи';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addTask();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Добавить'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
          ],
        );
      },
    );
  }

  void _addTask() async {
    final title = _titleController.text;
    final response = await Supabase.instance.client
        .from('todo')
        .insert({'title': title, 'isDone': 0});
    if (response.error != null) {
      print('Error adding task: ${response.error!.message}');
    } else {
      print('Task added successfully!');
      setState(() {
        _titleController.clear();
      });
    }
  }

  void _deleteTask(int taskId) async {
    final response = await Supabase.instance.client
        .from('todo')
        .delete()
        .eq('id', taskId);
    if (response.error != null) {
      print('Error deleting task: ${response.error!.message}');
    } else {
      print('Task deleted successfully!');
      setState(() {});
    }
  }

  void _toggleTaskDone(int taskId, bool isDone) async {
    final response = await Supabase.instance.client
        .from('todo')
        .update({'isDone': isDone ? 1 : 0})
        .eq('id', taskId);
    if (response.error != null) {
      print('Error toggling task done: ${response.error!.message}');
    } else {
      print('Task toggled successfully!');
      setState(() {});
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}