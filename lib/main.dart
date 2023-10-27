//import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoproject/firebase_options.dart';
import 'package:todoproject/layout/home_layout.dart';
import 'package:todoproject/providers/my_provider.dart';
import 'package:todoproject/screens/login/login.dart';
import 'package:todoproject/screens/signup/signup.dart';
import 'package:todoproject/screens/tasks/edit_task.dart';
import 'package:todoproject/shared/styles/theming.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context)=>MyProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:provider.firebaseUser!=null? HomeLayout.routeName: LoginScreen.routeName,
      routes: {
        HomeLayout.routeName:(context)=>HomeLayout(),
        EditTask.routeName:(context)=>EditTask(),
        SignUp.routeName:(context)=>SignUp(),
        LoginScreen.routeName:(context)=>LoginScreen(),

      },
      themeMode:ThemeMode.light ,
      theme: MyThemeData.lightTheme,
    );
  }
}

