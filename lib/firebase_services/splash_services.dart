import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_asif/UI/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context){
    Timer(Duration(seconds: 3), ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()))
    );
  }
}