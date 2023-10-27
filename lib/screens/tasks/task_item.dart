import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoproject/models/task_model.dart';
import 'package:todoproject/screens/tasks/edit_task.dart';
import 'package:todoproject/shared/network/firebase/firebase_manager.dart';

import '../../shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskItem (this.task,{super.key});
   TaskModel task ;
  @override
  Widget build(BuildContext context) {
    return Card (
      elevation: 12,
      margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: Colors.transparent)),
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(),
        children: [
          SlidableAction(onPressed: (BuildContext cotext){
            FirebaseManager.deleteTask(task.id);
          },
            spacing: 15,
          backgroundColor: Colors.red,
            label: "Delete",
            icon: Icons.delete,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),
                topLeft:Radius.circular(12) ),
          ),
          SlidableAction(onPressed: (BuildContext cotext){

            Navigator.pushNamed(context, "edit",arguments:
            TaskModel(id: task.id,title: task.title, time: task.time, date: task.date,isDone: task.isDone,
                userId: FirebaseAuth.instance.currentUser!.uid));
           // FirebaseManager.editTask(task);
          },
            spacing: 15,
            backgroundColor: Colors.blue,
            label: "Edit",
            icon:Icons.edit,

          )
        ],),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                height: 75,
                width: 4,
                decoration:BoxDecoration(

                    color:task.isDone?Color(0xFF61E757):Colors.blue,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: task.isDone?Color(0xFF61E757):Colors.blue)),
              ),
              SizedBox(width:20),
              Container(
                height: 110,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 31,
                    ),
                    Text(task.title,style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:task.isDone?Color(0xFF61E757):Colors.blue,
                    ),),
                    SizedBox(height: 15,),

                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: Color(0xFF363636)),
                        SizedBox(width: 5,),
                        Text(task.time,style: TextStyle(fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color:Color(0xFF363636),

                        ),),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: (){
                  FirebaseManager.updateTask(task.id, true);
                },
                child: Container(
                  width: 69,
                  height: 34,
                  decoration: BoxDecoration(
                    color:task.isDone?Colors.transparent:  primary,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child:task.isDone?Text("Done!",style: TextStyle(
                      color: Color(0xFF61E757),fontWeight:FontWeight.w600,fontSize: 22 ),textAlign: TextAlign.center,) :
                  Icon(Icons.done,color: Colors.white,size: 28),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
