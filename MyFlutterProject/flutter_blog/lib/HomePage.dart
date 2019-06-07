import 'package:flutter/material.dart';
import 'Authentication.dart';

class HomePage  extends StatefulWidget
{
  HomePage({
      this.auth,
      this.onSignedOut,
  });
     final AuthImplementation auth;
     final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() 
  {
    
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
{

    void _addFiles() async
    {
        try
        {
          await widget.auth.signOut();
          widget.onSignedOut();
        }
        catch(e)
        {
          print(e.toString());
        }
    }
                   
  @override
  Widget build(BuildContext context) {
   
    return new Scaffold
    (
        appBar: new AppBar(
          title: new Text ("Home"),
        ),

        body: new Container(

        ),

        bottomNavigationBar: new BottomAppBar(
          color: Colors.blue,

          child: new Container 
          (
            margin: const EdgeInsets.only(left: 50.0 , right: 50.0),
            child:new Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max ,

              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.attach_file),
                  iconSize: 50,
                  color: Colors.white,

                  onPressed: _addFiles,
                ),

                new IconButton(
                  icon: new Icon(Icons.chat),
                  iconSize: 50,
                  color: Colors.white,

                  
                  onPressed: null,
                )
              
                
              ],
            ),
          ),
        ),
        );
    
  }
}