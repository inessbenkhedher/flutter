import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}): super(key:key);

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.black,
                        ]
                    )
                ),
                child: Center(
                child: Column(

                  children:[
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/img.png"),
                      radius: 50,
                    ),

                    Text(
                    "black & black",
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                  ])


                )),
            ListTile(
              title: Text("Escaprins",style: TextStyle(fontSize: 26),),
              leading: Icon(Icons.home,color: Colors.black,),
              trailing: Icon(Icons.arrow_right,color: Colors.grey,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/home");
              },
            ),
            Divider(height: 5,color: Colors.black,),
            ListTile(
              title: Text("Mules",style: TextStyle(fontSize: 26),),
              leading: Icon(Icons.voice_chat_rounded,color: Colors.black,),
              trailing: Icon(Icons.arrow_right,color: Colors.grey,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/mules");
              },
            ),
            Divider(height: 5,color: Colors.black,),
            ListTile(
              title: Text("sandales",style: TextStyle(fontSize: 26),),
              leading: Icon(Icons.contact_page_outlined,color: Colors.black,),
              trailing: Icon(Icons.arrow_right,color: Colors.grey,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/sand");
              },
            ),
            Divider(height: 5,color: Colors.black,),
            ListTile(
              title: Text("signout",style: TextStyle(fontSize: 26),),
              leading: Icon(Icons.close,color: Colors.black,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/login");
              },

            )
          ],
        )
    );
  }}
