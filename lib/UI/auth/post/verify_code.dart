import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asif/UI/auth/post/post_screen.dart';

import '../../../util/utils.dart';
import '../../../widgets/round_button.dart';

class VerifyCode extends StatefulWidget {
  bool loading = false;
 final String verificationId;
   VerifyCode({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool loading=false;
  final verifyCodeControl = TextEditingController();
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
              controller: verifyCodeControl,
              decoration: const InputDecoration(
                hintText: 'enter 6 digit code',

              ),

            ),

          ),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RoundButton(title: 'Verify', loading: loading, onTap: () async{
              setState(() {
                loading=true;
              });
              final credential= PhoneAuthProvider.credential(

                  verificationId: widget.verificationId,

                   smsCode: verifyCodeControl.text.toString());
              try{
              await auth.signInWithCredential(credential);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()));
              }
              catch(e){
                setState(() {
                  loading=false;
                });
                Utils().ToastMessage.toString();

              }
              

            }),
          )

        ],
      ),
    );
  }
}
