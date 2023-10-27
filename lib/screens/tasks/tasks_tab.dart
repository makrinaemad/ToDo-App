import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoproject/models/task_model.dart';
import 'package:todoproject/screens/tasks/task_item.dart';
import 'package:todoproject/shared/network/firebase/firebase_manager.dart';
import 'package:todoproject/shared/styles/colors.dart';
 DateTime _selectedDate = DateTime.now();
class TasksTab extends StatefulWidget {


  @override
  State<TasksTab> createState() => _TasksTabState();

  static DateTime getselectdate() {
    if (_selectedDate==null)
      return DateTime.now();
    else
      return _selectedDate;
  }

}

class _TasksTabState extends State<TasksTab> {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: _selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {

              _selectedDate = date;
              setState(() {

              });

          },
         // onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor:primary ,
          dayColor: Colors.blueGrey,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primary,
          dotsColor: Color(0xFF333A47),
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',

        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
    stream: FirebaseManager.getTasks(_selectedDate),
    builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.waiting){
        return Center(
        child: CircularProgressIndicator(),
        );
    }
      if(snapshot.hasError){
        return Text("Something Went Wrong");
    }
      var tasks=snapshot.data?.docs.map((doc) => doc.data()).toList()??[];
          return ListView.builder(itemBuilder: (context, index) {
            return TaskItem(tasks[index]);
          },
    itemCount: tasks.length,
    );
    },
    ),
          //itemCount: 6,
          ),
      //  )
      ],
    );
  }


}
