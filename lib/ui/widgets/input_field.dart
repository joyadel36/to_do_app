import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../size_config.dart';
import '../theme.dart';

class InputField extends StatelessWidget {
  const InputField({Key? key,
    this.widget,
    required this.title,
    required this.hint,
    this.controller})
      : super(key: key);
  final Widget? widget;
  final String title;
  final String hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Titlestyle,),
          SizedBox(height: 5,),
        Container(
          padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
            height: 55,
            width:SizeConfig.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Get.isDarkMode ? Colors.white60 : Colors.blueGrey,
                )
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    style: SubTitlestyle,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: hint,
                      hintStyle: Body2lestyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .backgroundColor,
                          width: 0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .backgroundColor,
                          width: 0,
                        ),
                      ),

                    ),
                    cursorColor: Get.isDarkMode ? Colors.white60 : Colors
                        .blueGrey,
                    readOnly: widget != null ? true : false,
                  ),
                ),
                 widget ?? Container(),
              ],
            ),
          //),

        )],),
    );
  }
}
