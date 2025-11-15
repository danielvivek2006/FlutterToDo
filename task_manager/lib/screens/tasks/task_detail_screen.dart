import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import '../../theme/app_colors.dart';
import '../../models/task_model.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel? task;

  const TaskDetailScreen({Key? key, this.task}) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title ?? '';
      _descriptionController.text = widget.task!.description ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final currentUser = await ParseUser.currentUser();
    if (currentUser == null) {
      _showError('No user logged in.');
      setState(() => _isLoading = false);
      return;
    }

    final task = widget.task ?? TaskModel();
    task.title = _titleController.text.trim();
    task.description = _descriptionController.text.trim();
    task.user = currentUser;
    task.setACL(ParseACL(owner: currentUser));
    task.isCompleted = task.isCompleted ?? false; // Ensure isCompleted is not null

    final response = await task.save();

    setState(() => _isLoading = false);

    if (response.success) {
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      if (!mounted) return;
      _showError(response.error?.message ?? 'Failed to save task');
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
        leading: IconButton(
          icon: Icon(
            isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: colors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.task == null ? 'New Task' : 'Edit Task',
          style: isIOS
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: colors.textSecondary),
                    filled: true,
                    fillColor: colors.inputBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                      borderSide: BorderSide(color: colors.inputBorder, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                      borderSide: BorderSide(color: colors.primary, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  style: TextStyle(color: colors.textPrimary),
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: colors.textSecondary),
                    filled: true,
                    fillColor: colors.inputBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                      borderSide: BorderSide(color: colors.inputBorder, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                      borderSide: BorderSide(color: colors.primary, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                      ),
                      elevation: isIOS ? 0 : 2,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            widget.task == null ? 'Add Task' : 'Update Task',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}