import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label, required this.ontap}) : super(key: key);
  final String label;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>ontap(),
        child: Container(
          alignment: Alignment.center,
          height:50,
          width: 150,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: skyblue,
        ),
          child: Text(
           label,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Get.isDarkMode ? Colors.black:Colors.white),
          textAlign: TextAlign.center,),

        ));
  }
}
