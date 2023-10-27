import 'package:flutter/material.dart';
import 'package:todoproject/screens/login/login.dart';
import 'package:todoproject/shared/network/firebase/firebase_manager.dart';

class SignUp extends StatefulWidget {
  static const routeName = "signup";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  //final Box _boxAccounts = Hive.box("accounts");
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        // resizeToAvoidBottomInset: false,

        body: Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  // Text(
                  //   "Register",
                  //   style: Theme.of(context).textTheme.headlineLarge,
                  // ),
                  // const SizedBox(height: 10),
                  // Text(
                  //   "Create your account",
                  //   style: Theme.of(context).textTheme.bodyMedium,
                  // ),
                  //const SizedBox(height: 35),
                  TextFormField(
                    controller: _controllerUsername,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter username.";
                        // } else if (_boxAccounts.containsKey(value)) {
                        // return "Username is already registered.";
                      }

                      return null;
                    },
                    onEditingComplete: () => _focusNodeEmail.requestFocus(),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _controllerEmail,
                    focusNode: _focusNodeEmail,
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
                      } else if (!(value.contains('@') &&
                          value.contains('.'))) {
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
                    onEditingComplete: () =>
                        _focusNodeConfirmPassword.requestFocus(),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _controllerConFirmPassword,
                    obscureText: _obscurePassword,
                    focusNode: _focusNodeConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      prefixIcon: const Icon(Icons.password_outlined),
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
                      } else if (value != _controllerPassword.text) {
                        return "Password doesn't match.";
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
                            FirebaseManager.createAcount(_controllerUsername.text,
                                _controllerEmail.text, _controllerPassword.text,
                                () {

                              Navigator.pushNamed(
                                  context, LoginScreen.routeName);
                            }, (e) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (cotext) => AlertDialog(
                                  title: Text("Error"),
                                  content: Text(e.toString()),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Okay"))
                                  ],
                                ),
                              );
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                width: 200,
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                behavior: SnackBarBehavior.floating,
                                content: const Text("Registered Successfully\nPlease Verify Your Email"),
                              ),
                            );
                            _formKey.currentState?.reset();
                            //Navigator.pop(context);
                             Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                          }
                        },
                        child: const Text("SignUp"),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text("Already have an account?"),
                      //     TextButton(
                      //       onPressed: () =>
                      //           //Navigator.pop(context),
                      //           Navigator.pushNamed(
                      //               context, LoginScreen.routeName),
                      //       child: const Text("Login"),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
