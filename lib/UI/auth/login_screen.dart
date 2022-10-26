import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asif/UI/auth/post/post_screen.dart';
import 'package:flutter_asif/util/utils.dart';

import '../../widgets/round_button.dart';
import 'sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey  = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth =FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void Login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {
          Utils().ToastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
          setState(() {
            loading = false;
          });

        
    }).onError((error, stackTrace) {

      debugPrint(error.toString());
      Utils().ToastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                children: [
                  TextFormField(

                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                    ),
                  validator: (value){
                      if(value!.isEmpty)
                        {
                          return 'enter email';
                        }
                      else
                        return null;
                  },
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password_outlined),
                      hintText: 'Password',
                    ),
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'enter password';
                      }
                      else
                        return null;
                    },
                  ),
                ],
              )), SizedBox(
                height: 50,
              ),


              RoundButton(title: 'Login', loading: loading  , onTap: (){

                if(_formKey.currentState!.validate()) {
                  Login();

                }
              },),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have account?'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                  } , child: Text('Sign Up'))
                ],
              )
            ],
        ),
      ),
    );
  }
}
