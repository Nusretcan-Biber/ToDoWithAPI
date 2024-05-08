import 'package:todo_app/constans/tasktype.dart';

class Task{
  Task({
    required this.title,
    required this.description,
    required this.inCompleted,
    required this.type
  });
  final TaskType type;
  final String title;
  final String description;
  bool inCompleted;
}