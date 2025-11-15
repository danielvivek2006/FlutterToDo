import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import '../theme/app_colors.dart';

class TaskGroupCard extends StatelessWidget {
  final String title;
  final int taskCount;
  final Color color;
  final VoidCallback onTap;

  const TaskGroupCard({
    Key? key,
    required this.title,
    required this.taskCount,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isIOS = !kIsWeb && Platform.isIOS;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: colors.cardBackground,
        elevation: isIOS ? 0 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isIOS ? CupertinoIcons.circle_fill : Icons.circle,
                color: color,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                '$taskCount Tasks',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colors.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}