import 'dart:math';
import 'package:flutter/material.dart';

class Laundry extends StatefulWidget {
  const Laundry({super.key});

  @override
  State<Laundry> createState() => _LaundryState();
}

class _LaundryState extends State<Laundry> {
  List<bool> _isSelected = [false, false];
  List<int> _ratings = [];
  double _averageRating = 0.0;
  final _random = Random();

  void _addRating() {
    setState(() {
      // Simulate a new rating between 1 and 5
      int newRating = _random.nextInt(5) + 1;
      _ratings.add(newRating);
      _calculateAverage();
    });
  }

  void _calculateAverage() {
    if (_ratings.isNotEmpty) {
      _averageRating = _ratings.reduce((a, b) => a + b) / _ratings.length;
    } else {
      _averageRating = 0.0;
    }
  }

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
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isSelected = [false, false]; // Reset to default state
                  });
                },
                child: Text(
                  "LAUND",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
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
      body: _isSelected[0]
          ? const Profile() // Show Profile content if the first toggle button is selected
          : _isSelected[1]
          ? const Company() // Show Business content if the second toggle button is selected
          : _buildLaundryContent(screenWidth), // Default content (or any other content when no toggle is selected)
    );
  }

  Widget _buildLaundryContent(double screenWidth) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.location_on),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueAccent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("FIND BEST LAUNDRY SHOP",
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.white,
                              )),
                          Text(
                            "Near by",
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return Container(
                  height: screenWidth * 0.15,
                  width: screenWidth * 0.15,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                );
              }),
            ),
            SizedBox(height: 10),
            _buildRatingContainer(screenWidth),
            _buildRatingContainer(screenWidth),
            _buildRatingContainer(screenWidth),
            _buildRatingContainer(screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingContainer(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        width: screenWidth,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return Container(
                  height: screenWidth * 0.15,
                  width: screenWidth * 0.15,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Company name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: _addRating, // Add a new rating on tap
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        _averageRating.toStringAsFixed(1), // Display the average rating
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  '${_ratings.length} Ratings',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on),
                Text("cross cut road, gamthipuram"),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                Text("great service and neatly ironed and ..."),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton("Call Now", Colors.blueAccent, Colors.white),
                _buildActionButton("Chat", Colors.transparent, Colors.black),
                _buildActionButton("Chat", Colors.transparent, Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color bgColor, Color textColor) {
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor,
        border: Border.all(),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 8),
                      Text(
                        "Profile page",
                        style: TextStyle(fontSize: screenWidth * 0.05),
                      ),
                    ],
                  ),
                  Icon(Icons.cancel_outlined),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/4,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name"),
                        Card(
                          elevation: 10,
                          child: Container(
                            height: screenHeight * 0.05,
                            width: screenWidth*0.9,
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Name"),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Mobile number"),
                        Card(
                          elevation: 10,
                          child: Container(
                            height: screenHeight * 0.05,
                            width: screenWidth*0.9,
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("9876543210"),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Email Id"),
                        Card(
                          elevation: 10,
                          child: Container(
                            height: screenHeight * 0.05,
                            width: screenWidth*0.9,
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("abcd@gmail.com"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Card(
                elevation: 10,
                child: Container(
                  height: screenHeight * 0.05,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      Text("Coimbatore tamil nadu")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 10,
                child: Stack(
                  children: [
                    Container(
                      height: screenHeight * 0.25,
                      width: screenWidth,
                      decoration: BoxDecoration(),
                      child: Center(
                        child: Text(
                          "Change password",
                          style: TextStyle(fontSize: screenWidth * 0.05),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Icon(Icons.cancel_presentation_outlined, size: 30,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: screenHeight * 0.2,
                width: screenWidth,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(child: Text("LAUND ad banner1", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 24),)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: "Blog",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Store",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page_outlined),
            label: "Request",
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
              ),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("")
                        )
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Increse Business profile to reach out more customer", softWrap: true,
                          maxLines: 3, // Adjust this value based on how many lines you want
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                        GestureDetector(
                          onTap:(){
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=> book()));
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueAccent
                            ),
                            child: Center(child: Text("Book Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("My Business",style: TextStyle(color: Colors.blueAccent,fontSize: 25,fontWeight: FontWeight.w600),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
              ),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("")
                        )
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20,top:8 ),
                        child: Text("My Leads", softWrap: true,
                          maxLines: 3, // Adjust this value based on how many lines you want
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.blueAccent),),
                      ),
                      Text("To view your leads", softWrap: true,
                        maxLines: 3, // Adjust this value based on how many lines you want
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),

                    ],
                  )
                ],
              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
              ),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("")
                        )
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20,top: 8),
                        child: Text("Catalogue", softWrap: true,
                          maxLines: 3, // Adjust this value based on how many lines you want
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.blueAccent),),
                      ),
                      Text("Showcase products & Services", softWrap: true,
                        maxLines: 3, // Adjust this value based on how many lines you want
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),

                    ],
                  )
                ],
              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
              ),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("")
                        )
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20,top: 8),
                          child: Text("Advertise on Laund", softWrap: true,
                            maxLines: 3, // Adjust this value based on how many lines you want
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.blueAccent),),
                        ),
                        Text("Reach out wide range of customers", softWrap: true,
                          maxLines: 3, // Adjust this value based on how many lines you want
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),

                      ],
                    ),
                  )
                ],
              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
              ),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("")
                        )
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20,top: 8),
                        child: Text("Catalogue", softWrap: true,
                          maxLines: 3, // Adjust this value based on how many lines you want
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.blueAccent),),
                      ),
                      Text("Showcase products & Services", softWrap: true,
                        maxLines: 3, // Adjust this value based on how many lines you want
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),

                    ],
                  )
                ],
              ),
            ),
          ),
          Center(child: TextButton(onPressed: (){}, child: Text("Change password",style: TextStyle(color: Colors.blueGrey),)))
        ],
      ),
    );
  }
}
