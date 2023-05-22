import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen(this.payload, {Key? key}) : super(key: key);
  final payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';

  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Colors.white,
            )),
        title: Text(
          _payload.toString().split('|')[0],
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
              color: Get.isDarkMode ? Colors.white : darkHeaderClr),
        ),
        backgroundColor: Get.isDarkMode ? Colors.black : skyblue,
        centerTitle: true,
        elevation: 10,
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            'Hello Joy !',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Get.isDarkMode ? Colors.white : darkGreyClr),
          ),
          SizedBox(height: 10),
          Text(
            'You have a task to do now',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Get.isDarkMode ? Colors.white : darkHeaderClr),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: skyblue,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.text_format,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Title',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _payload.toString().split('|')[0],
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: darkGreyClr),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                        thickness: 2,
                        endIndent: 20,
                        indent: 20,
                        color: Colors.grey[400]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _payload.toString().split('|')[1],
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: darkGreyClr),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                        thickness: 2,
                        endIndent: 20,
                        indent: 20,
                        color: Colors.grey[400]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.lock_clock,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Time',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _payload.toString().split('|')[2],
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: darkGreyClr),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
