import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app/models/user_model.dart';
import 'package:task_app/services/services.dart';

final userDataProvider =
    FutureProvider.autoDispose<List<UserModel>>((ref) async {
  return ref.watch(userProvider).getUSers();
});
