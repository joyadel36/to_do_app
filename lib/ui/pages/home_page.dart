import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/services/notification_services.dart';
import 'package:to_do/ui/pages/add_task_page.dart';
import 'package:to_do/ui/widgets/button.dart';
import 'package:to_do/ui/widgets/input_field.dart';
import 'package:to_do/ui/widgets/task_tile.dart';

import '../../services/theme_services.dart';
import '../size_config.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selecteddate = DateTime.now();
  late NotifyHelper notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    _taskController.gettasks();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _createappbar(),
      body: SafeArea(
        child: Container(
          child: Column(children: [
            _Taskbar(),
            _Datebar(),
            _Showtasks(),
          ]),
        ),
      ),
    );
  }

  AppBar _createappbar() {
    return AppBar(
      leading: IconButton(
          onPressed: () async {
            ThemeServices().Switchthememode();
          },
          icon: Get.isDarkMode
              ? Icon(
                  Icons.sunny,
                  size: 20,
                  color: Colors.white,
                )
              : Icon(
                  Icons.nightlight_round_outlined,
                  size: 20,
                  color: Colors.black,
                )),
      backgroundColor: Theme.of(context).backgroundColor,
      centerTitle: true,
      elevation: 3,
      actions: [
        IconButton(
            onPressed: () async {
              _taskController.deletealltaskfromdb();
              notifyHelper.cancelallNotification();
            },
            icon: Get.isDarkMode
                ? Icon(
              Icons.cleaning_services_rounded,
              size: 20,
              color: Colors.white,
            )
                : Icon(
              Icons.cleaning_services_rounded,
              size: 20,
              color: Colors.black,
            )),
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 20,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  Container _Taskbar() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 10 : 5),
          vertical: getProportionateScreenHeight(
            SizeConfig.orientation == Orientation.landscape ? 5 : 10,
          )),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()).toString(),
                style: Titlestyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Today",
                style: SubTitlestyle,
              ),
            ],
          ),
          MyButton(
              label: '+ Add Task',
              ontap: () async {
                await Get.to(() => const AddTaskPage());
                _taskController.gettasks();
              }),
        ],
      ),
    );
  }

  Container _Datebar() {
    return Container(
        margin: EdgeInsets.only(
            top: getProportionateScreenHeight(8),
            bottom: getProportionateScreenHeight(8),
            left: getProportionateScreenWidth(8)),
        padding: EdgeInsets.all(10),
        child: DatePicker(
          DateTime.now(),
          width: 70,
          height: 100,
          selectionColor: skyblue,
          monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          initialSelectedDate: _selecteddate,
          onDateChange: (newdate) {
            setState(() {
              _selecteddate = newdate;
            });
          },
        ));
  }

  _Showtasks() {
    return Expanded(child: Obx(
      () {
        if (_taskController.listoftasks.isEmpty) {
          return _notasks();
        } else {
          return RefreshIndicator(
            onRefresh: _Refresh,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _taskController.listoftasks.length,
                itemBuilder: (BuildContext context, int index) {
                  var task = _taskController.listoftasks[index];
                  if (task.date == DateFormat.yMd().format(_selecteddate) ||
                      task.repeat == 'Daily' ||
                      (task.repeat == 'Weekly' && _selecteddate.difference(DateFormat.yMd().parse(task.date!)).inDays % 7 == 0)||
                      (task.repeat == 'Monthly'&& DateFormat.yMd().parse(task.date!).day==_selecteddate.day )) {
                    var hour = task.startTime.toString().split(':')[0];
                    var minute =
                        task.startTime.toString().split(':')[1].split(' ')[0];
                    notifyHelper.scheduledNotification(
                        int.parse(hour), int.parse(minute), task);
                    //notifyHelper.displayNotification(title: task.title.toString(), note:task.note.toString(),time:task.startTime.toString());
                    return GestureDetector(
                      onTap: () => _ShowBottomSheet(context, task),
                      child: TaskTile(task: task),
                    );
                  } else {
                    return Container();
                  }
                }),
          );
        }
      },
    ));
  }

  _notasks() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
          top: getProportionateScreenHeight(8),
          bottom: getProportionateScreenHeight(8),
          left: getProportionateScreenWidth(8)),
      child: Column(
        children: [
          FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minWidth: 100, minHeight: 150), // here
                  child: Image.asset(
                    'images/list.jpg',
                  ))),
          SizedBox(
            height: 20,
          ),
          Text(
            "You don't have any tasks \n You can add tasks now ",
            style: Titlestyle,
          )
        ],
      ),
    );
  }

  _ShowBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.3
                : SizeConfig.screenHeight * 0.5),
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(
                SizeConfig.orientation == Orientation.landscape ? 10 : 5),
            vertical: getProportionateScreenHeight(
              SizeConfig.orientation == Orientation.landscape ? 5 : 10,
            )),
        margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 10 : 5,
            ),
            vertical: getProportionateScreenHeight(
              SizeConfig.orientation == Orientation.landscape ? 5 : 10,
            )),
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            task.isCompleted == 1
                ? Container()
                : _buildBottomSheet(
                    ontap: () {
                      notifyHelper.cancelNotification(task);
                      _taskController.marktaskascomplete(task.id!);
                      Get.back();
                    },
                    label: 'The Task Completed',
                    color: skyblue),
            SizedBox(
              height: 20,
            ),
            _buildBottomSheet(
                ontap: () {
                  notifyHelper.cancelNotification(task);
                  _taskController.deletetaskfromdb(task);
                  Get.back();
                },
                label: 'Remove Task',
                color: skyblue),
            Divider(
              color: Colors.grey,
            ),
            _buildBottomSheet(
                ontap: () {
                  Get.back();
                },
                label: 'Cancel',
                color: skyblue),
          ],
        ),
      ),
    ));
  }

  _buildBottomSheet({
    required Function ontap,
    required String label,
    required Color color,
    bool isclosed = false,
  }) {
    return GestureDetector(
        onTap: () => ontap(),
        child: Container(
          height: (SizeConfig.orientation == Orientation.landscape)
              ? SizeConfig.screenHeight * 0.6 / 3
              : SizeConfig.screenHeight * 0.3 / 3,
          width: SizeConfig.screenWidth * 0.9,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 3,
                  color: isclosed
                      ? Get.isDarkMode
                          ? Colors.white
                          : Colors.black
                      : color),
              borderRadius: BorderRadius.circular(30),
              color: isclosed
                  ? Get.isDarkMode
                      ? Colors.white
                      : darkHeaderClr
                  : color),
          child: Center(
            child: Text(
              "$label",
              style: Titlestyle.copyWith(color: Colors.white),
            ),
          ),
        ));
  }

  Future<void> _Refresh() async {
    _taskController.gettasks();
  }
}
