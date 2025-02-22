import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client; // Получаем клиент Supabase

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class Task {
  final String title;
  final bool isDone;

  Task({required this.title, required this.isDone});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] ?? 'Без названия',
      isDone: (json['isDone'] as bool?) ?? false, // Обрабатываем null
    );
  }
}

class _MyWidgetState extends State<MyWidget> {
  Future<List<Task>> fetchTasks() async {
    try {
      final response = await supabase.from('todo').select('title, isDone');

      if (response.isEmpty) {
        print('Список задач пуст');
        return [];
      }

      return response.map<Task>((json) => Task.fromJson(json)).toList();
    } catch (e) {
      print('Ошибка при загрузке задач: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo App with Innoprog"),
      ),
      body: FutureBuilder<List<Task>>(
        future: fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Ошибка: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Нет задач"));
          }

          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                trailing: task.isDone ? const Text("✅") : const Text("❌"),
              );
            },
          );
        },
      ),
    );
  }
}
