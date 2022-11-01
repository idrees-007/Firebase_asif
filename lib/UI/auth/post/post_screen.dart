import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asif/util/utils.dart';
import 'add_posts.dart';

import '../login_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('post');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.onValue.listen((event) {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: const Text('Post Screen'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
            });

          }, icon: const Icon( Icons.login_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchFilter,
              decoration: const InputDecoration(
                hintText: 'search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),


              ),
              onChanged: (String Value){
                setState(() {

                });
              },
            ),
            //optional
          /*   Expanded(child: StreamBuilder (
              stream: ref.onValue,

               builder:(context, AsyncSnapshot<DatabaseEvent> snapshot){

                if(!snapshot.hasData)
                  {
                      return CircularProgressIndicator();
                  }
                else {
                  Map<dynamic, dynamic > map =snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> list= [];
                  list.clear();
                  list = map.values.toList();
                  return ListView.builder(
                      itemCount:  snapshot.data!.snapshot.children.length,
                      itemBuilder: (context, index){

                        return ListTile(

                          title: Text(list [index]['title']),
                          subtitle: Text(list [index] ['id']),
                        );
                      });

                }



            }),
            ),

           */
             Expanded(
               child: FirebaseAnimatedList(query: ref, itemBuilder: ( context,  snapshot,  animation,  index) {
                final title= (snapshot.child('title').value.toString());
                if(searchFilter.text.isEmpty){
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert), itemBuilder: (BuildContext context) => [
                         PopupMenuItem(
                            value :1,
                            child: ListTile (
                              onTap: (){
                                Navigator.pop(context);
                                ShowMyDialog(title , snapshot.child('id').value.toString());


                              },

                              leading: Icon(Icons.add),
                              title: Text('Edit'),
                            ) ),
                       PopupMenuItem(
                          value :1,
                          child: ListTile (
                            onTap: (){
                              Navigator.pop(context);
                              ref.child(snapshot.child('id').value.toString()).remove();
                            },


                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          ) )
                    ],
                    ),
                  );
                }
                else if(title.toString().contains(searchFilter.text.toString())) {
                return ListTile(
                title: Text(snapshot.child('title').value.toString()),
                 subtitle: Text(snapshot.child('id').value.toString()),
                 );
                }
                else {
                          return Container();
                }

               }

               ),
             ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPostScreen()));

      },
      child: const Icon(Icons.add),
      ),


    );
  }
  Future<void> ShowMyDialog(String title, String id) async{
    editController.text= title ;
    return showDialog(
        context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('update'),
        content: Container(
          child: TextField(
            controller: editController,
            decoration: InputDecoration(
              hintText: 'Enter Your Text',
              
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel')),
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.child(id).update({
              'title' : editController.text.toString(),
            }).then((value) {
              Utils().ToastMessage('post updated');
            }).onError((error, stackTrace) {
              Utils().ToastMessage(error.toString());
            });
          }, child: Text('update'))
        ],
      );
    }

    );
  }
}
