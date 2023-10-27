import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoproject/layout/home_layout.dart';
import 'package:todoproject/models/task_model.dart';
import 'package:todoproject/shared/network/firebase/firebase_manager.dart';

class EditTask extends StatefulWidget {
  static const String routeName="edit";

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var selectedTime="";

  var titleController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var task=ModalRoute.of(context)?.settings.arguments as TaskModel;
    var selectedTime=task.time;
    String updatedText="ff" ;
    titleController =TextEditingController(text: task.title);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("To Do List"),
            ),
            body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              "Edit Task",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            controller: titleController,
            // onChanged: (newText) {
            //   setState(() {
            //     updatedText = newText;
            //   });
            // },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue)),
            ),
          ),
          SizedBox(
            height: 18,
          ),

          SizedBox(
            height: 18,
          ),
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
              " ${selectedTime}",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 18,),

          InkWell(
            onTap: (){

              FirebaseManager.editTask(task);
              task.title=updatedText;
              task.time=selectedTime;
            },
            child:
    ElevatedButton(onPressed: (){
              showDialog(context: context,
                builder:(context) {
                  return AlertDialog(
                    title: Text("Successfully"),
                    content: Text("The Task has been Edited"),
                    actions: [
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pushNamed(context,HomeLayout.routeName);
                      }, child: Text("OK")),
                    ],
                  );
                },);
             }, child: Text("Save Changes"),
           ),
          ) ],
      ),
    )));
  }

  selectTime() async{
    TimeOfDay? time =await
    showTimePicker(context: context, initialTime:TimeOfDay.now());

    if(time==null)
      return;
    selectedTime=time.toString();
    setState(() {

    });
  }
}
