import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'layout/home_layout.dart';

abstract class BaseConnector{
showMessage(String message);
showLoading(String txt);
hidePopup();

}

class BaseViewModel<CON extends BaseConnector>extends ChangeNotifier{
   CON? connector;
}
 abstract class BaseView <VM extends BaseViewModel,S extends StatefulWidget>
    extends State<S> implements BaseConnector{
late VM viewModel;

VM initViewModel();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel=initViewModel();
  }
@override
hidePopup(){
  Navigator.pop(context);
}

@override
showLoading(String txt) {
  showDialog(context: context,
      barrierDismissible: false
      , builder: (context)=>AlertDialog(
        title: Center(child: CircularProgressIndicator(),),
      ));
}

@override
showMessage(String message) {
  showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=>AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Okay"))
        ],
      ));
}
}