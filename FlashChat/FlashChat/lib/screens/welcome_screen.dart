// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../Components/RoundedButton.dart';

class WelcomeScreen extends StatefulWidget {



  static String id = 'welcome_screen';


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
        );
    animation = ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(controller);


    controller.forward();
    controller.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Flash Chat',
                    textStyle: const TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black
                    ),
                    speed: const Duration(milliseconds: 80)),
                  ],

                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              txt: 'Log In',
              color:Colors.lightBlueAccent,
              onPressed:() {
                Navigator.pushNamed(context,LoginScreen.id);
              },
            ),
            RoundedButton(
              txt: 'Register',
              color:Colors.blueAccent,
              onPressed:() {
                Navigator.pushNamed(context,RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}