import 'package:flutter/material.dart';

class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                         Container(
                           height: 30,
                           width: 100,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Colors.blueAccent
                           ),
                           child: Center(child: Text("Book Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
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
      ),
    );
  }
}
