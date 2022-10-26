import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asif/UI/auth/login_screen.dart';

import '../UI/auth/post/post_screen.dart';

class SplashServices {
  void isLogin(BuildContext context){
    final auth =FirebaseAuth.instance;
    final user=  auth.currentUser;
    if(user != null)
      {
        Timer(Duration(seconds: 3), ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()))
        );
      }
    else {
      Timer(Duration(seconds: 3), ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()))
      );
    }

  }
}