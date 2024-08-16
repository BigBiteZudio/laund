import 'package:flutter/material.dart';

import 'Laundry.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(child: Text("Laund",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.white),)),
          SizedBox(
            height: 400,
          ),
          GestureDetector(
        onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Laundry()));},
        child: Container(
          height: 50,
          width: 350,
          decoration: BoxDecoration(
              boxShadow:[
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(30),
              color: Colors.white
          ),
          child: Center(child: Text("User Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blueAccent),)),
        ),
      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                    onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Laundry()));},
                    child: Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(
                boxShadow:[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
            ),
            child: Center(child: Text("Business Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blueAccent),)),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
