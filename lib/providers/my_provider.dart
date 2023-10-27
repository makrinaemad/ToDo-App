import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoproject/models/user_model.dart';
import 'package:todoproject/shared/network/firebase/firebase_manager.dart';

class MyProvider extends ChangeNotifier{

  UserModel? userModel;
  User? firebaseUser;
  MyProvider(){
  firebaseUser=FirebaseAuth.instance.currentUser;
  if(firebaseUser!=null){
    initUser();
  }
  }
initUser() async{
  firebaseUser=FirebaseAuth.instance.currentUser;
    userModel=await FirebaseManager.readUser(firebaseUser!.uid);
    notifyListeners();
}
}