import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app/constants/colors.dart';
import 'package:task_app/data_provider/data_provider.dart';
import 'package:task_app/features/dashboard/widgets/custom_card.dart';
import 'package:task_app/models/task_data_model.dart';
import 'package:task_app/utils/loader.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(taskDataProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                  color: ConstantsColors.greyColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                ),
              ),
              const Text('Explore'),
              Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                  color: ConstantsColors.greyColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_active),
              ),
            ],
          ),
        ),
      ),
      body: data.when(
        data: (data) {
          List<TaskDataModel> dataList = data.map((e) => e).toList();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                          title: dataList[index].caption,
                          time: dataList[index].createdAt,
                          uri: dataList[index].videoUrl,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Loader(),
      ),
    );
  }
}
