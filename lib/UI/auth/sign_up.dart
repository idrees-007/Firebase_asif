
import 'package:flutter/material.dart';
import 'package:flutter_asif/UI/auth/login_screen.dart';
import 'package:flutter_asif/util/utils.dart';

import '../../widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formKey  = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final FirebaseAuth _auth =FirebaseAuth.instance;
  @override

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
  void SignUp(){
    if(_formKey.currentState!.validate()) {
      setState(() {
        loading= true;
      });
      _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()).then((value){
        setState(() {
          loading= false;
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
        });

      }).onError((error, stackTrace) {
        Utils().ToastMessage(error.toString());
        setState(() {
          loading= false;
        });
      });

    }
  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign Up'),
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
                        else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    const SizedBox(
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
                        else {
                          return null;
                        }
                      },
                    ),
                  ],
                )), const SizedBox(
              height: 50,
            ),


            RoundButton(title: 'Sign Up',loading: loading, onTap: (){

              SignUp();


            },),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Dont have account?'),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                } , child: const Text('Login '))
              ],
            )
          ],
        ),
      ),
    );
  }
}
