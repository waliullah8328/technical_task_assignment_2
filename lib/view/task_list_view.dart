import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/todo_model.dart';
import '../resource/app_string.dart';
import '../resource/custom_widgets/custom_loading_widget.dart';
import '../view_model/task_list_view_model.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskListViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          AppStrings.taskList,
          style: TextStyle(fontSize: 21, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: controller.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomLoadingWidget());
          }  else if (controller.data.contains('empty')) {
            return const Center(child: Text("No data available")); // Display message for empty data
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.updateData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  final task = controller.data[index];

                  // Ensure task is a Map with expected keys
                  final id = task["id"]?.toString() ?? "N/A";
                  final title = task["title"] ?? "No Title";
                  final userId = task["userId"]?.toString() ?? "Unknown User";
                  final completed = task["completed"]?.toString() ?? "N/A";

                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(id),
                    ),
                    title: Text(title),
                    subtitle: Text("User ID: $userId"),
                    trailing: Text(completed),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
