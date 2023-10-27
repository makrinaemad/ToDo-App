import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoproject/models/task_model.dart';

import '../../../models/user_model.dart';


class FirebaseManager{
  
  static CollectionReference<TaskModel> getTasksCollection(){
    return
    FirebaseFirestore.instance.collection("Tasks").withConverter(
        fromFirestore: (snapshot, _) {
          return TaskModel.fromJson(snapshot.data()!);
        }, toFirestore: (value, _) {
          return value.toJson();
        },);
  }
  static CollectionReference<UserModel> getUsersCollection(){
    return
      FirebaseFirestore.instance.collection("Users").withConverter(
        fromFirestore: (snapshot, _) {
          return UserModel.fromJson(snapshot.data()!);
        }, toFirestore: (value, _) {
        return value.toJson();
      },);
  }
  static  Future<void> addUserToFirestore(UserModel user){
    var collection=getUsersCollection();
    var docRef=collection.doc(user.id);
    return docRef.set(user);
  }
  static Future<UserModel?> readUser(String id)async{
    DocumentSnapshot<UserModel>userDoc=await
     getUsersCollection().doc(id).get();
    return userDoc.data();
  }
static Future<void> addTask(TaskModel task){
    var collection=getTasksCollection();
    var docRef=collection.doc();
    task.id=docRef.id;
    return docRef.set(task);
}
static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime d){
    return getTasksCollection().where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
         isEqualTo:DateUtils.dateOnly(d).millisecondsSinceEpoch).snapshots();
}
 static Future<void> deleteTask (String id){
    return getTasksCollection().doc(id).delete();
}
  static Future<void> updateTask (String id,bool done){
    return getTasksCollection().doc(id).update({"isDone":done});
  }
  static Future<void> editTask (TaskModel task){
    return getTasksCollection().doc(task.id).update(task.toJson());
  }

  static Future<void> createAcount(String name,String email,String password,Function onSuccess,Function onError)async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
       if(credential.user?.uid!=null){
         UserModel user=UserModel(id:credential.user!.uid,name:name,email: email);
         credential.user!.sendEmailVerification();
         addUserToFirestore(user);
         onSuccess();
       }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
       // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        //print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  }
