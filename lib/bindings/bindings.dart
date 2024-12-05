import 'package:get/get.dart';

import '../view_model/task_list_view_model.dart';




class ControllerBinders extends Bindings{
  @override
  void dependencies() {

    Get.put(TaskListViewModel());




  }

}