import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';
import 'sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey  = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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


              RoundButton(title: 'Login', onTap: (){

                if(_formKey.currentState!.validate()) {

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
