 import 'package:flutter/material.dart';
import 'package:todoproject/shared/styles/colors.dart';

class MyThemeData{
  static ThemeData lightTheme=ThemeData(
      scaffoldBackgroundColor: mintGreen,
      // appBarTheme: const AppBarTheme(
      //   iconTheme:IconThemeData(color: Colors.black),
      //   centerTitle: true,
      //   elevation: 0.0,
      // backgroundColor: Colors.transparent),
      bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor:primary ,
        unselectedItemColor:Colors.grey,
      )
  );
  static ThemeData darkTheme=ThemeData();
}
