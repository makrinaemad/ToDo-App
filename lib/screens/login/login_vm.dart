import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:todoproject/base.dart';
import 'package:todoproject/screens/login/login_connector.dart';

class LoginViewModel extends BaseViewModel<LoginConnector>{
  Future<void> login(String email,String password)async{//,Function onSuccess,Function onError
    connector!.showLoading("Wait");
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if(credential.user!.emailVerified){
    //    onSuccess();
        connector!.hidePopup();
        connector!.goToHome();
      }
      else {
      //  onError("Please Verify Your Email!");
        connector!.showMessage("Please Verify Your Email!");
      }
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found'||e.code == 'wrong-password') {
      //onError("Wrong Email Or Password");
      //  }
      connector!.hidePopup();
      connector!.showMessage("Wrong Email Or Password");
    }
  }
}