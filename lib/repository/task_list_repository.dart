

import '../data/network_caller.dart';
import '../model/network_response_model.dart';
import '../resource/urls.dart';

class TaskListRepository {


  static Future<dynamic> getTaskList() async {

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.todoApi);

    return response;
  }

}