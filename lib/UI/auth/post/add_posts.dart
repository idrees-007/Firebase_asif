import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asif/util/utils.dart';
import 'package:flutter_asif/widgets/round_button.dart';
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postEditingController = TextEditingController();
  bool loading=false;
  final databaseRef = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add posts Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLength: 200,
              maxLines: 4,
              controller: postEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter Any thing',
                border: OutlineInputBorder(),

              ),
              
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(title: 'Add', loading: loading , onTap: (){
              setState(() {
                loading= true ;
              });
              databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                'title': postEditingController.text.toString(),
                'id': DateTime.now().millisecondsSinceEpoch.toString(),

              }).then((value) {
                setState(() {
                  loading= false ;
                });
                Utils().ToastMessage('Text Added');
              }).onError((error, stackTrace)
              {
                setState(() {
                  loading= false ;
                });
                Utils().ToastMessage(error.toString());
              });

            })
            

          ],
        ),
      ),
    );
  }
}
