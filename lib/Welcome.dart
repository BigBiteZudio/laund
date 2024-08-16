import 'package:flutter/material.dart';

import 'logsignup.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 30),
                    child: Text("WELCOME TO",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                  Center(child: Text("Laund",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.white),)),
                  Center(child: Image.network("https://tse4.mm.bing.net/th?id=OIP.NBQTSO6j46apSr8px6IvDQHaHa&pid=Api&P=0&h=180"))
                ],
              ),
            ),
            SizedBox(
              height: 200,
            ),
            GestureDetector(
              onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogSign()));},
              child: Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueAccent
                ),
                child: Center(child: Text("Get Started",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
