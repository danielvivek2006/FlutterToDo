import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import '../../theme/app_colors.dart';
import '../../models/task_model.dart';
import 'task_detail_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    setState(() => _isLoading = true);
    final currentUser = await ParseUser.currentUser();
    if (currentUser != null) {
      final queryBuilder = QueryBuilder<TaskModel>(TaskModel())
        ..whereEqualTo('user', currentUser)
        ..orderByAscending('createdAt');
      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        setState(() {
          _tasks = response.results!.map((e) => e as TaskModel).toList();
        });
      }
    }
    setState(() => _isLoading = false);
  }

  Future<void> _toggleTaskCompletion(TaskModel task) async {
    final getTaskResponse = await TaskModel().getObject(task.objectId!);
    if (getTaskResponse.success) {
      final taskToUpdate = getTaskResponse.result as TaskModel;
      taskToUpdate.isCompleted = !(taskToUpdate.isCompleted ?? false);
      final response = await taskToUpdate.save();
      if (response.success) {
        _fetchTasks();
      } else {
        _showError(response.error?.message ?? 'Failed to update task');
      }
    } else {
      _showError(getTaskResponse.error?.message ?? 'Failed to get task for updating');
    }
  }

  Future<void> _deleteTask(TaskModel task) async {
    final getTaskResponse = await TaskModel().getObject(task.objectId!);
    if (getTaskResponse.success) {
      final taskToDelete = getTaskResponse.result as TaskModel;
      final response = await taskToDelete.delete();
      if (response.success) {
        _fetchTasks();
      } else {
        _showError(response.error?.message ?? 'Failed to delete task');
      }
    } else {
      _showError(getTaskResponse.error?.message ?? 'Failed to get task for deletion');
    }
  }

  void _showError(String message) {
    final isIOS = !kIsWeb && Platform.isIOS;
    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isIOS = !kIsWeb && Platform.isIOS;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          'My Tasks',
          style: isIOS
              ? Theme.of(context).textTheme.displayLarge
              : Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: Icon(isIOS ? CupertinoIcons.add : Icons.add, color: colors.primary),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TaskDetailScreen()),
              );
              if (result != null) {
                _fetchTasks();
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
              ),
            )
          : _tasks.isEmpty
              ? Center(
                  child: Text(
                    'No tasks yet. Add one!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return Card(
                      color: colors.cardBackground,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(
                          task.title ?? 'No Title',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: colors.textPrimary,
                                decoration: (task.isCompleted ?? false)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                        ),
                        subtitle: Text(
                          task.description ?? 'No Description',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: colors.textSecondary,
                                decoration: (task.isCompleted ?? false)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                        ),
                        leading: Checkbox(
                          value: task.isCompleted ?? false,
                          onChanged: (bool? value) {
                            _toggleTaskCompletion(task);
                          },
                          activeColor: colors.primary,
                          checkColor: colors.textPrimary,
                        ),
                        trailing: IconButton(
                          icon: Icon(isIOS ? CupertinoIcons.pencil : Icons.edit, color: colors.primary),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TaskDetailScreen(task: task),
                              ),
                            );
                            if (result != null) {
                              _fetchTasks();
                            }
                          },
                        ),
                        onLongPress: () {
                          if (isIOS) {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _deleteTask(task);
                                    },
                                    isDestructiveAction: true,
                                    child: const Text('Delete Task'),
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                              ),
                            );
                          } else {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.delete, color: colors.error),
                                      title: Text('Delete Task', style: TextStyle(color: colors.error)),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _deleteTask(task);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
    );
  }
}