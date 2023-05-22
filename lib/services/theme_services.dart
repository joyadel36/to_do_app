import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  GetStorage _Themesdata=GetStorage();
  final String _Key='theme mode';
 bool Get_Themesdata(){
    return _Themesdata.read<bool>(_Key)??false;
  }
void Set_Themesdata(bool thememode){
    _Themesdata.write(_Key, thememode);
  }
  void Switchthememode(){
   Get.changeThemeMode(thememode);
   Set_Themesdata(!Get_Themesdata());
  }
  ThemeMode get thememode => Get_Themesdata()? ThemeMode.light:ThemeMode.dark;

}
