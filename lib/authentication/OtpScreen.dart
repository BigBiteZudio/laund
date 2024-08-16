import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Laundry.dart';


class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key,
    required this.verificationId
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();
  final otpControllers = List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){

          },
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
        ),
        backgroundColor: Colors.black,
        title: const Text("OTP Verification",  style: TextStyle(color: Colors.white,fontSize: 16)),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) => otpTextField(context, index)),
            ),

            GestureDetector(
              onTap: () async {
                try {
                  String otp = otpControllers.map((controller) => controller.text).join();
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode:otp,
                  );
                  await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Laundry()));
                  });
                } catch (ex) {
                  log(ex.toString());
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  height: MediaQuery.of(context).size.height/18,
                  width: MediaQuery.of(context).size.width/1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text("Verify",
                        style:Theme.of(context).textTheme.headlineSmall),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget otpTextField(BuildContext context,int index) {
    return Form(
      child: SizedBox(
        height: 70,
        width: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: otpControllers[index],
            onChanged: (value){
              if(value.length==1){
                FocusScope.of(context).nextFocus();
              }
            },
            onSaved: (pin1){},
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],

            decoration: const InputDecoration(
                hintText: "0",
                border: OutlineInputBorder()
            ),
          ),
        ),
      ),
    );
  }
}


