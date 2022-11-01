import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
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
                final title= Text(snapshot.child('title').value.toString());
                if(searchFilter.text.isEmpty){
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
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
}
