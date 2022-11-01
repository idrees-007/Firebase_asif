import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asif/UI/auth/post/verify_code.dart';
import 'package:flutter_asif/widgets/round_button.dart';

import '../../util/utils.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading=false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with phone number'),
        centerTitle: true,
      ),
      body: Column(
        children: [


          
          const SizedBox(

            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                hintText: '+923000000000',

              ),

            ),

          ),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RoundButton(title: 'Submit', loading: loading, onTap: (){

              setState(() {
                loading=true;
              });
            auth.verifyPhoneNumber(
              phoneNumber: phoneNumberController.text,
                verificationCompleted: (_){
                  setState(() {
                    loading=false;
                  });
                },
                verificationFailed: (e){
                  setState(() {
                    loading=false;
                  });
                Utils().ToastMessage(e.toString());
                },
                codeSent: (String verificationId, int? token ) {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCode(verificationId: verificationId,)));
                  setState(() {
                    loading=false;
                  });
                },
                codeAutoRetrievalTimeout: (e){
                  Utils().ToastMessage(e.toString());
                  setState(() {
                    loading=false;
                  });
                },
            );

              //
            }),
          )

        ],
      ),
    );
  }
}
