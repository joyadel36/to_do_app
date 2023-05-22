import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/db/db_helper.dart';
import 'package:to_do/models/task.dart';

class TaskController extends GetxController{
  final RxList<Task> listoftasks = <Task>[ ].obs;
  Future<void> gettasks() async {
    final List<Map<String, dynamic>> tasks= await DBHelper.query();
    listoftasks.assignAll(tasks.map((data) =>Task.fromJson(data) ).toList());
  }
  Future<int> settaskindb(Task task) async {
    return await DBHelper.insert(task);
  }

  void deletetaskfromdb(Task task) async {
     await DBHelper.delete(task);
    gettasks();
  }
  void deletealltaskfromdb() async {
    await DBHelper.deleteall();
    gettasks();
  }

 void marktaskascomplete(int id) async {
     await DBHelper.update(id);
    gettasks();
  }


}
