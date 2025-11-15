import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TaskModel extends ParseObject implements ParseCloneable {
  TaskModel() : super(_className);
  TaskModel.clone() : this();

  static const String _className = 'Task';

  @override
  TaskModel clone(Map<String, dynamic> map) => TaskModel.clone()..fromJson(map);

  String? get title => get<String>('title');
  set title(String? value) => set<String>('title', value!);

  String? get description => get<String>('description');
  set description(String? value) => set<String>('description', value!);

  bool? get isCompleted => get<bool>('isCompleted');
  set isCompleted(bool? value) => set<bool>('isCompleted', value!);

  ParseUser? get user => get<ParseUser>('user');
  set user(ParseUser? value) => set<ParseUser>('user', value!);
}