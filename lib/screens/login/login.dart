import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoproject/base.dart';
import 'package:todoproject/layout/home_layout.dart';
import 'package:todoproject/screens/login/login_vm.dart';
import 'package:todoproject/screens/signup/signup.dart';
import 'package:todoproject/shared/network/firebase/firebase_manager.dart';

import '../../providers/my_provider.dart';
import 'login_connector.dart';

class LoginScreen extends StatefulWidget {
  static const routeName="login";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginViewModel,LoginScreen>implements
    LoginConnector {
 // var provider=Provider.of<MyProvider>(context);
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
  TextEditingController();
  LoginViewModel viewModel= LoginViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector=this;
  }
  //final Box _boxAccounts = Hive.box("accounts");
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return ChangeNotifierProvider(
      create: (context)=>viewModel,
     builder:(context,child)=> DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,

          appBar: AppBar(
            title: Text("ToDo App"),
            bottom: TabBar(tabs: [
              Tab(
                text: "LogIn",
              ),
              Tab(
                text: "SignUp",

              )
            ]),
          ),
   backgroundColor : Colors.white,
      body: TabBarView(
        children: [
        Form(
        key: _formKey,
        child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
        children: [
        const SizedBox(height: 100),
        TextFormField(
        controller: _controllerEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        ),
        ),
        validator: (String? value) {
        if (value == null || value.isEmpty) {
        return "Please enter email.";
        } else if (!(value.contains('@') && value.contains('.'))) {
        return "Invalid email";
        }
        return null;
        },
        onEditingComplete: () => _focusNodePassword.requestFocus(),
        ),
        const SizedBox(height: 10),
        TextFormField(
        controller: _controllerPassword,
        obscureText: _obscurePassword,
        focusNode: _focusNodePassword,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.password),
        suffixIcon: IconButton(
        onPressed: () {
        setState(() {
        _obscurePassword = !_obscurePassword;
        });
        },
        icon: _obscurePassword
        ? const Icon(Icons.visibility_outlined)
            : const Icon(Icons.visibility_off_outlined)),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        ),
        ),
        validator: (String? value) {
        if (value == null || value.isEmpty) {
        return "Please enter password.";
        } else if (value.length < 8) {
        return "Password must be at least 8 character.";
        }
        return null;
        },
        ),
        const SizedBox(height: 50),
        Column(
        children: [
        ElevatedButton(
        style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        ),
        ),
        onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
             viewModel.login(_controllerEmail.text,_controllerPassword.text);
          // FirebaseManager.login(_controllerEmail.text, _controllerPassword.text,
          //         (){
          //           provider.initUser();
          //       Navigator.pushReplacementNamed(context, HomeLayout.routeName);
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(
          //           width: 200,
          //           backgroundColor:
          //           Theme.of(context).colorScheme.secondary,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           behavior: SnackBarBehavior.floating,
          //           content:   Text("Welcom "),
          //         ),
          //       );
          //     }, (e){
          //       showDialog(
          //         context: context,
          //         barrierDismissible: false,
          //         builder: (cotext) => AlertDialog(
          //           title: Text("Error"),
          //           content: Text(e),
          //           actions: [
          //             ElevatedButton(
          //                 onPressed: () {
          //                   Navigator.of(context).pop();
          //                 },
          //                 child: Text("Okay"))
          //           ],
          //         ),);
          //     });


        _formKey.currentState?.reset();

        //Navigator.pop(context);


        }
        },
        child: const Text("LogIn"),
        ),

        ],
        ),
        ],
        ),
        ),
        ),SignUp()],
      ),
),


        ),
    );
  }

  @override
  goToHome() {
            //  provider.initUser();
          Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }


}
