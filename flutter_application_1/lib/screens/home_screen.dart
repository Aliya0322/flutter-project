import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список задач'),
      ),
      body: TaskListView(),
    );
  }
}

class TaskListView extends StatelessWidget {
  TaskListView({Key? key}) : super(key: key);
  
  final List<Map<String, dynamic>> tasks = [
    {"title": "Задача 1", "completed": false},
    {"title": "Задача 2", "completed": false},
    {"title": "Задача 3", "completed": false},
    {"title": "Задача 4", "completed": false},
    {"title": "Задача 5", "completed": false},
    {"title": "Задача 6", "completed": false},
    {"title": "Задача 7", "completed": false},
    {"title": "Задача 8", "completed": false},
    {"title": "Задача 9", "completed": false},
    {"title": "Задача 10", "completed": false},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tasks.map((task) {
        return Container(
          padding: EdgeInsets.all(16),
            child: Text(
              task["title"],
              style: TextStyle(
                fontSize: 20,
              ),
            ),
        );
      }).toList(),
    );
  }
}