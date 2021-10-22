import 'package:chat_app/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _remail="";
  String _rpassword="";
  String _rusername="";

  final GlobalKey<FormState> _rformkey = GlobalKey<FormState>();


  Future<void>register()async{
    final formstate = _rformkey.currentState;
    if(formstate!.validate()){
      formstate.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _remail, password: _rpassword);
        // UserName uName= new UserName();
        // uName.setUserName(_rusername.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Loginpage(_rusername)));

      }
      catch(e){
        print(e);

      }

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),

      body: Form(
        key: _rformkey,
          child: Column(
            children: [


              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "User Name"
                  ),
                  onSaved: (input){
                    setState(() {
                      _rusername=input!;
                    });
                  },
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email"
                  ),
                  onSaved: (input){
                    setState(() {
                      _remail=input!;
                    });
                  },
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Password"
                  ),
                  onSaved: (input){
                    setState(() {
                      _rpassword=input!;
                    });
                  },
                ),
              ),


              SizedBox(height: 10,),
              FlatButton(
                  color: Colors.teal,
                  onPressed: (){
                    setState(() {
                      register();
                    });
                  },
                  child: Text("Create Account")
              )




            ],
          ),
      ),
    );
  }
}
