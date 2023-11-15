// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:motion_toast/motion_toast.dart';
import '../Components/RoundedButton.dart';

class LoginScreen extends StatefulWidget {

  static String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;
  late String pwd;
  bool showS=false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showS,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration: kInputDecorationOfAuth.copyWith(hintText: 'Enter Your Email')
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pwd =value;
                },
                decoration: kInputDecorationOfAuth.copyWith(hintText: 'Enter Your Password')
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                txt: 'Log In',
                color:Colors.lightBlueAccent,
                onPressed:() async {
                  setState(() {
                    showS = true;
                  });
                  try{
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: pwd);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showS = false;
                    });
                  }
                  catch(e){
                    setState(() {
                      showS = false;
                    });
                    MotionToast.error(
                        title:  Text("Error"),
                        description:  Text(e.toString())
                    ).show(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
