import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/size_config.dart';
import 'package:to_do/ui/theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.orientation == Orientation.landscape?SizeConfig.screenWidth/2:SizeConfig.screenWidth,
        decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(20),
          color: _choosencolor(task.color),
        ),
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 10 :5),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${task.title}",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                ),
                Row(children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.blueGrey,
                  ),

                  Text("${task.startTime} _ ${task.endTime}",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(fontSize: 15, color: Colors.white70),
                      )),
                ]),

                Text(
                  "${task.note}",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            width: 0.8,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted == 0 ? "DoTask" : "Done",
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontSize: 15, color: Colors.blueGrey),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _choosencolor(int? color) {
    switch (color) {
      case 0:
        return palegreen;
      case 1:
        return salmon;
      default:
        return skyblue;
    }
  }
}
