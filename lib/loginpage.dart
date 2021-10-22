import 'package:chat_app/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/chatpage.dart';

class Loginpage extends StatefulWidget {
  //const Loginpage({Key? key}) : super(key: key);

  String name;
  Loginpage(this.name);

  @override
  _LoginpageState createState() => _LoginpageState(name);
}

class _LoginpageState extends State<Loginpage> {
  String name;
  _LoginpageState(this.name);
  String _email="",_password="";
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();



  Future<void>signIn()async{
    final formstate = formkey.currentState;
    if(formstate!.validate()){
      formstate.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(name)));
      }
      catch(e){
        print(e);

      }

    }
  }

  bool hidePassword = false;
  
  Future PassOnOff () async{
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      
      
      body: Form(
        key: formkey,
          child: Column(
            children: [


              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  onSaved: (input){
                    setState(() {

                      _email=input!;

                    });
                  },
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextFormField(
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: InkWell(
                      onTap: PassOnOff,
                      child: hidePassword ? Icon(Icons.visibility_off):Icon(Icons.visibility),
                    )
                  ),
                  onSaved: (input){
                    setState(() {

                      _password=input!;

                    });
                  },
                ),
              ),



              SizedBox(height: 15,),
              FlatButton(
                color: Colors.teal,
                  onPressed: (){
                    setState(() {

                      signIn();

                    });
                  },
                  child: Text("Login")
              ),


              SizedBox(height: 10,),
              FlatButton(
                  color: Colors.teal,
                  onPressed: (){
                    setState(() {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));

                    });
                  },
                  child: Text("Create Account")
              )


            ],
          )
      ),
    );
  }
}
