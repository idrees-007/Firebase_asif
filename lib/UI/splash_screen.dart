import 'package:flutter/material.dart';
import 'package:flutter_asif/firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  SplashServices splashScreen = SplashServices();
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);

  }
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen', style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
