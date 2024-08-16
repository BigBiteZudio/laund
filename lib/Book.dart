import 'package:flutter/material.dart';

class book extends StatefulWidget {
  const book({super.key});

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  List<bool> _isSelected = [false, false];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "LAUND",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ToggleButtons(
                isSelected: _isSelected,
                onPressed: (int index) {
                  setState(() {
                    // Ensure only one button is selected at a time
                    _isSelected = List.generate(
                        _isSelected.length, (i) => i == index);
                  });
                },
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF063970),
                selectedColor: Colors.white,
                fillColor: Color(0xFF063970),
                children: [
                  Icon(Icons.person_rounded),
                  Icon(Icons.format_bold),
                ],
              ),
              Icon(
                Icons.menu,
                size: screenWidth * 0.08,
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 10,
                color: Colors.grey.shade400,
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(

                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.blue),
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("COMPANY NAME",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 24),),
                            Text("Coimbatore tamil nadu"),
                            SizedBox(height: 10,),
                            Card(
                              elevation: 10,
                              color: Colors.blue,
                              child: Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(child: Text("Edit now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(child: Text("Business Profile Score",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 24),)),
              SizedBox(height: 10,),

              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: 300,
                  height: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      backgroundColor: Color(0xffD6D6D6),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 80,),
                        Text("Add two or more contacts",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 80,),
                        Text("Add map location",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),


                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 80,),
                        Text("Add social media channels",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 80,),
                        Text("Get upto 10 reviews",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),


              Center(
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width/2.2,
                  decoration: BoxDecoration(
                      border: Border.all()
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 75,),
                      Text("Upload your photos and videos",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
