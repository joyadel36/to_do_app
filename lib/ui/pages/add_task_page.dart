import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/theme.dart';
import 'package:to_do/ui/widgets/button.dart';
import '../size_config.dart';
import '../widgets/input_field.dart';
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}
class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _Notecontroller = TextEditingController();
  DateTime _selectdate = DateTime.now();
  String _starttime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endtime = DateFormat('hh:mm a')
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();
  int _selectedremind = 5;
  List<int> _remindlist = [5, 10, 15, 20];
  String _selectedrepeat = 'None';
  List<String> _repeatlist = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedcolor = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _createappbar(),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputField(
                  hint: 'Enter title here',
                  title: 'Title',
                  controller: _titlecontroller,
                ),
                InputField(
                  hint: 'Enter note here',
                  title: 'Note',
                  controller: _Notecontroller,
                ),
                InputField(
                  hint: _selectdate.toString(),
                  title: 'Date',
                  widget: IconButton(
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.blueGrey,
                      size: 30,
                    ),
                    onPressed: () {
                      _getdate();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        hint: _starttime,
                        title: 'Start',
                        widget: IconButton(
                          icon: Icon(
                            Icons.access_time,
                            color: Colors.blueGrey,
                            size: 30,
                          ),
                          onPressed: () {
                            _gettime(true);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: InputField(
                        hint: _endtime,
                        title: 'End',
                        widget: IconButton(
                          icon: Icon(
                            Icons.timer_outlined,
                            color: Colors.blueGrey,
                            size: 30,
                          ),
                          onPressed: () {
                            _gettime(false);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                InputField(
                  hint: "$_selectedremind minutes early",
                  title: 'Remind',
                  widget: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    elevation: 10,
                    style: SubTitlestyle,
                    underline: Container(
                      height: 0,
                    ),
                    iconSize: 30,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blueGrey,
                      size: 30,
                    ),
                    onChanged: (String? newvalue) {
                      setState(() {
                        _selectedremind = int.parse(newvalue!);
                      });
                    },
                    items: _remindlist
                        .map<DropdownMenuItem<String>>(
                            (int value) =>
                            DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(
                                  '$value',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )))
                        .toList(),
                  ),
                ),
                InputField(
                  hint: _selectedrepeat,
                  title: 'Repeat',
                  widget: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    elevation: 10,
                    style: SubTitlestyle,
                    underline: Container(
                      height: 0,
                    ),
                    iconSize: 30,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blueGrey,
                      size: 30,
                    ),
                    onChanged: (String? newvalue) {
                      setState(() {
                        _selectedrepeat = newvalue!;
                      });
                    },
                    items: _repeatlist
                        .map<DropdownMenuItem<String>>(
                            (String value) =>
                            DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  '$value',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )))
                        .toList(),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Colors",
                          style: Titlestyle,
                        ),
                        MyButton(
                            label: 'Add Task',
                            ontap: () => _checkavailability()),
                      ],
                    ),
                    _listofcolor(),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _listofcolor() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(3, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedcolor = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CircleAvatar(
                radius: 15,
                child: _selectedcolor == index
                    ? Icon(
                  Icons.done,
                  color: Colors.white,
                )
                    : null,
                backgroundColor: (index == 0)
                    ? skyblue
                    : (index == 1)
                    ? salmon
                    : palegreen,
              ),
            ),
          );
        }));
  }

  AppBar _createappbar() {
    return AppBar(
      title: Text(
        "Create Task",
        style: Headingstyle,
      ),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: Colors.grey,
        ),
      ),
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      centerTitle: true,
      elevation: 3,
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 20,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _checkavailability() async {
    if (_titlecontroller.text.isNotEmpty && _Notecontroller.text.isNotEmpty) {
      await _addtasktodb();
      Get.back();
    } else  {
      Get.snackbar(
        "Requirement",
        'You must fill all field',
        duration: Duration(seconds: 15),
        borderRadius: 20,
        backgroundColor: Get.isDarkMode ? Colors.white : darkHeaderClr,
        icon: Icon(
          Icons.error_outline_outlined,
          color: Colors.red,
        ),
        colorText: Get.isDarkMode ? darkHeaderClr : Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  _addtasktodb() async {
    int val;
    try{
      val = await _taskController.settaskindb(Task(
      title: _titlecontroller.text,
      note: _Notecontroller.text ,
      isCompleted: 0,
      date:DateFormat.yMd().format(_selectdate),
      startTime: _starttime,
      endTime: _endtime,
      color: _selectedcolor,
      remind: _selectedremind,
      repeat: _selectedrepeat,
    ));
      print("\n $val");}catch(e){
      print("\n $e");
    }

  }

  _getdate() async {
    DateTime? _PackedDte = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
        context: context,
        initialDate: _selectdate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (_PackedDte != null) {
      setState(() {
        _selectdate = _PackedDte;
      });
    } else {
      print("No date selected");
    }
  }

  _gettime(bool isstarttime) async {
    TimeOfDay? _PackedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: isstarttime
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(
            DateTime.now().add(Duration(minutes: 30))));
    if (_PackedTime != null && isstarttime) {
      setState(() {
        _starttime = _PackedTime.format(context);
      });
    } else if (_PackedTime != null && !isstarttime) {
      setState(() {
        _endtime = _PackedTime.format(context);
      });
    } else {
      print("No time selected");
    }
  }
}
