import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app/models/task_data_model.dart';
import 'package:task_app/services/services.dart';

final userDataProvider =
    FutureProvider.autoDispose<List<TaskDataModel>>((ref) async {
  return ref.watch(userProvider).getUSers();
});
