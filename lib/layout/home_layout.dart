import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoproject/screens/login/login.dart';
import 'package:todoproject/screens/settings/settings_tab.dart';
import 'package:todoproject/screens/tasks/add_task_bottomsheet.dart';
import 'package:todoproject/screens/tasks/tasks_tab.dart';
import 'package:todoproject/shared/styles/colors.dart';

import '../providers/my_provider.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "homeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
int indx=0;

List<Widget>tabs=[TasksTab(),SettingsTab()];
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: mintGreen,
      appBar: AppBar(
        actions: [
          IconButton(onPressed:(){
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
          },icon: Icon(Icons.logout),)
        ],
        title: Text("To Do List "),//${provider.userModel?.name}
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){
        showAddTaskBottomSheet();
      },
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.white,width: 3),
        ),
      child: Icon(Icons.add),),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        color: Colors.white,
        shape: CircularNotchedRectangle(
        ),
        child: BottomNavigationBar(
         // backgroundColor: Colors.transparent,
          currentIndex:indx ,
          onTap: (value){
            indx=value;
            setState(() {
            });
          },

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
      body: tabs[indx],
    );}
    showAddTaskBottomSheet(){
      showModalBottomSheet( context:context,
        isScrollControlled: true,
        builder:(context){
        return Padding(
          padding: EdgeInsets.only(bottom:MediaQuery.of(context).
          viewInsets.bottom),
          child: AddTaskBottomSheet(),
        );
      },);
    }

}
