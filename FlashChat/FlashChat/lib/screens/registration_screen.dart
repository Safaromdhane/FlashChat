// ignore_for_file: library_private_types_in_public_api, import_of_legacy_library_into_null_safe

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../Components/RoundedButton.dart';
import 'package:flashchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {

  static String id = 'registration_screen';

  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth =FirebaseAuth.instance;
  bool showspinner = false;
  late String email;
  late String pwd;


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
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
                  pwd=value;
                },
                decoration: kInputDecorationOfAuth.copyWith(hintText: 'Enter Your Password')
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                txt: 'Register',
                color:Colors.blueAccent,
                onPressed:() async {
                  setState(() {
                    showspinner=true;
                  });
                  try{
                  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: pwd);
                  if(newUser != null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showspinner=false;
                  });
                  }
                  catch(e){
                    setState(() {
                      showspinner=false;
                    });
                    MotionToast.error(
                        title:  Text("Error"),
                        description:  Text(e.toString())
                    ).show(context);
                    print(e);
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
