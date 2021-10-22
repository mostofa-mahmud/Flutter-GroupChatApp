import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  //ChatPage({Key? key}) : super(key: key);
  String users;
  ChatPage(this.users);

  @override
  _ChatPageState createState() => _ChatPageState(users);
}

class _ChatPageState extends State<ChatPage> {
  String users = ' ';
  _ChatPageState(this.users);
  String message="";
  Firestore firestore = Firestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

late FirebaseUser user;

Future<void> GetUser()async{
  FirebaseUser userEmail = await FirebaseAuth.instance.currentUser();
  setState(() {
    user = userEmail;
  });
}
@override
void initState(){
  super.initState();
  GetUser();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Page"),
      ),



      body: StreamBuilder(
                stream: Firestore.instance.collection("User").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
                  if(!snapshot.hasData){
                    return Text("No Value");
                  }
                  return ListView(
                    children: snapshot.data!.documents.map((document){
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(document['User'] ?? " ",style: TextStyle(color: Colors.red),),
                                  Text(document['Message'] ?? " "),
                                ],
                              ),
                              subtitle: Text(document['Email'] ?? " "),
                            )
                            //Text(document['userEmail'] ?? " "),

                          ],
                        ),
                      );
                    }).toList(),
                  );
                }
                ),




      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        color: Colors.teal,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Message",
                ),
                onChanged: (input){
                  message = input;
                  },
              ),
            ),



            FlatButton(
              color: Colors.teal,
              onPressed: ()async{
                firestore.collection('User').document().setData({
                  'Message':message,
                  'Email': user.email,
                  'User': this.users

                }).then((value) => print("Data Added"));

              },
              child: Icon(Icons.send),
            ),




          ],
        ),
      ),
    );
  }
}
