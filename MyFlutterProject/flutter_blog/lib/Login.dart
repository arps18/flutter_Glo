import 'package:flutter/material.dart';
import 'Authentication.dart';

class LoginPage extends StatefulWidget
 {
   LoginPage({
     this.auth,
     this.onSignedIn,
   });
   final AuthImplementation auth;
  final VoidCallback onSignedIn;
  State<StatefulWidget> createState()
   {
    return _LoginState();
  }
   
}

enum FormType { login, register }

class _LoginState extends State<LoginPage> {
  
  final formkey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  //methods
  bool validateAndSave() {
    final form =formkey.currentState;

    if(form.validate()){
      form.save();
      return true;

    }
    else{
      return false;
    }
  }

  void validateAndSubmit() async
  {
      if (validateAndSave())
      {
        try
        {
            if(_formType == FormType.login)
            {
              String userId = await widget.auth.SignIn(_email, _password);
              print('login userId=' + userId);
            }
            else
            {
              String userId = await widget.auth.SignUp(_email, _password);
              print(' Register   userId=' + userId);

            }
            widget.onSignedIn();
        }
        catch(e)
        {
          print("Error =" + e.toString());

        }
      }
  }
  void moveToRegister() {
    formkey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formkey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  //Design
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("                      Flutter Global"),
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Form(

          key: formkey,
          child: SingleChildScrollView
          (
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          ),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),

        validator: (value){
          return value.isEmpty? 'Email is Required' : null;
        },
        onSaved: (value){
          return _email = value;

        },
      ),
      SizedBox(
        height: 10.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,

         validator: (value){
          return value.isEmpty? 'Password is Required' : null;
        },
        onSaved: (value){
          return _password = value;

        },
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget logo() {
    return new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('image/global.jpg'),
      ),
    );
  }

  List<Widget> createButtons() {
   if (_formType == FormType.login){
      return [
      new RaisedButton(
        child: new Text(
          'Login',
          style: new TextStyle(fontSize: 20.0),
        ),
        textColor: Colors.black,
        color: Colors.lightBlue,
        onPressed: validateAndSave,
      ),
      new FlatButton
      (
        child: new Text
        (
          'New User? Create Account',
          style: new TextStyle(fontSize: 14.0),
        ),
        textColor: Colors.purple,
        onPressed: moveToRegister,
      ),
    ];
   }
   else {
      return [
      new RaisedButton
      (
        child: new Text
        ( 'Create Account',
          style: new TextStyle(fontSize: 20.0),
        ),
        textColor: Colors.black,
        color: Colors.lightBlue,
        onPressed: validateAndSubmit,
      ),
      new FlatButton(
        child: new Text
        (
          'Already Have an Account? Login',
          style: new TextStyle(fontSize: 14.0),
        ),
        textColor: Colors.purple,
        onPressed: moveToLogin,
      ),
    ];
   }
  }
  
}
