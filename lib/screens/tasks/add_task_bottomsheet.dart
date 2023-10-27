import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoproject/models/task_model.dart';
import 'package:todoproject/screens/tasks/tasks_tab.dart';
import 'package:todoproject/shared/network/firebase/firebase_manager.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();
  var selectedTime=TimeOfDay.now();
 // var selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add New Task",
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue)),
              hintText: "Enter Your Task",
            ),
          ),
          SizedBox(
            height: 18,
          ),

          // SizedBox(
          //   height: 18,
          // ),
          Text(
            "Select Time",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 9,
          ),
          InkWell(
            onTap: (){
              selectTime();
            },
            child: Text(
              " ${selectedTime.toString().substring(9)}",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 18,),
          ElevatedButton(onPressed: (){
          TaskModel task=TaskModel(title: titleController.text,
            time: selectedTime.toString().substring(9),
            date:selectdate(),
            userId: FirebaseAuth.instance.currentUser!.uid,
           );
          if(task.title!=""){
         FirebaseManager.addTask(task).then((value) {
           showDialog(context: context,
               builder:(context) {
                 return AlertDialog(
                   title: Text("Successfully"),
                   content: Text("Tasks Added To Firebase"),
                   actions: [
                     ElevatedButton(onPressed: (){
                       Navigator.pop(context);  //close alert
                      Navigator.pop(context);  // close bottomsheet
                     }, child: Text("Thank You"))
                   ],
                 );
               },);
         //  Navigator.pop(context);
           });}
          else {showDialog(context: context,
            builder:(context) {
              return AlertDialog(
                title: Text("Empty!"),
                content: Text("No Tasks Added"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);  //close alert
                    Navigator.pop(context);  // close bottomsheet
                  }, child: Text("Close"))
                ],
              );
            },);}
          }, child: Text("Add Task"))
        ],
      ),
    );
  }

 selectTime() async{
    TimeOfDay? time =await
    showTimePicker(context: context, initialTime:TimeOfDay.now());

    if(time==null)
      return;
    selectedTime=time;
    setState(() {

    });
  }
  String getTitle(){
    return titleController.text;
  }
  String getTime(){
    return selectedTime.toString().substring(9);
  }

  int selectdate() {
    int d;
    DateTime date = TasksTab.getselectdate();
    d=DateUtils.dateOnly(date).millisecondsSinceEpoch;
    return d;

  }

}
