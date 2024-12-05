import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;  // Add alias 'http'


class TaskListViewModel extends GetxController {
  final RxBool _inProgress = false.obs;
  final RxBool _isSuccess = false.obs;
  final RxString _errorMessage = ''.obs;

   late Box box;
   List data=[];

  // Public getters
  bool get inProgress => _inProgress.value;
  bool get isSuccess => _isSuccess.value;
  String get errorMessage => _errorMessage.value;




  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox("data");
    return;
  }
/*
  @override
  void onInit() {
    super.onInit();
    getAllData();

  }*/

  Future putData(data) async {
   await  box.clear();
   for( var d in data){
     box.add(d);
   }
  }


 Future<bool> getAllData() async {
    await openBox();
    _inProgress.value = true;
    update();

    String url = "https://jsonplaceholder.typicode.com/todos";
    try{
      var response = await http.get(Uri.parse(url));
      var _jsonDecode = jsonDecode(response.body);
      await putData(_jsonDecode);
      _inProgress.value = false;
      update();

    }catch (SocketException){
      print("No Internet");
      _inProgress.value = false;
      update();
      
    }
    _inProgress.value = false;
    update();

     var myMap = box.toMap().values.toList();
    if(myMap.isEmpty){
      data.add("empty");

    }else{
      data = myMap;
    }
    return Future.value(true);
  }

  Future<void> updateData() async {
    await openBox();
    _inProgress.value = true;
    update();

    String url = "https://jsonplaceholder.typicode.com/todos";
    try{
      var response = await http.get(Uri.parse(url));
      var _jsonDecode = jsonDecode(response.body);
      await putData(_jsonDecode);
      _inProgress.value = false;
      update();

    }catch (SocketException){
      print("No Internet");

      _inProgress.value = false;
      update();
      Get.snackbar("Error", "No Internet");

    }

  }




}
