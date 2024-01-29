import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class HotelDescription extends StatefulWidget {
  final hotelDetail;
  const HotelDescription({Key? key, required this.hotelDetail}) : super(key: key);

  @override
  State<HotelDescription> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HotelDescription> {

  bool isDetailsLoading = false;

  Future<void> getHotelDetailsByHotelID(String hotelID, String resultIndex, String traceId) async {
    final url = Uri.parse('https://traveldemo.org/travelapp/b2capi.asmx/AdivahaHotelGetDetailsByHotelID');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = 'HotelID=$hotelID&ResultIndex=$resultIndex&TraceId=$traceId';

    try {
      setState(() {
        isDetailsLoading = true;
      });
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      setState(() {
        isDetailsLoading = false;
      });

      if (response.statusCode == 200) {
        // Handle the successful response here
        print('Request successful!');
        developer.log(response.body);

      } else {
        // Handle the failure scenario
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions or errors that occurred during the request
      print('Error sending request: $error');
    }
  }


  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: TabBar(
              labelColor: Colors.black,
                isScrollable: true,
                tabs: [
              Tab(child: Text("OVERVIEWS", style: TextStyle(fontFamily: ("Montserrat")),),),
              Tab(child: Text("AMENITIES", style: TextStyle(fontFamily: ("Montserrat")),),),
              Tab(child: Text("REVIEWS", style: TextStyle(fontFamily: ("Montserrat")),),),
              Tab(child: Text("LOCATIONS", style: TextStyle(fontFamily: ("Montserrat")),),),
              Tab(child: Text("QNA", style: TextStyle(fontFamily: ("Montserrat")),),),
              Tab(child: Text("POLICIES", style: TextStyle(fontFamily: ("Montserrat")),),),
            ]),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [

              Container(
                  margin: EdgeInsets.all(10),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 15,
                                        itemPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      SizedBox(width: 10,),

                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 0.5, color: Colors.black),
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white
                                        ),

                                        child: Text("HOTEL", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),

                                      ),

                                      SizedBox(width: 10,),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(width: 65, height: 30, decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Color(0xFFFADEE0),
                                          ),),
                                          Text("27% Off", style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16),)
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.hotelDetail['HotelName'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Icon(const IconData(0xf053c, fontFamily: 'MaterialIcons'), size: 15,),
                                          SizedBox(width: 5,),
                                          Text(widget.hotelDetail['Address'], style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(width: 55, height: 25, decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Color(0xFF00AF80),
                                          ),),
                                          Text(" 4.1 / 5 ", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),)
                                        ],
                                      ),
                                      SizedBox(width: 10,),
                                      Text("487 ratings", style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.black,
                                          fontSize: 16),),

                                      SizedBox(width: 10,),

                                      Text("Based on last ten reviews", style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.grey,
                                          fontSize: 16),),


                                    ],),
                                  SizedBox(height: 10,),

                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on, color: Colors.blue, size: 20,),
                                        SizedBox(width: 5,),
                                        Expanded(child: Text(widget.hotelDetail['Address'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blue)))
                                      ],
                                    ),
                                  ),
                                  Container(width: double.infinity, height: 0.1, color:  Colors.grey,),

                                  SizedBox(height: 10,),

                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.local_offer, color: Colors.black54, size: 15,),
                                        SizedBox(width: 10,),
                                        Text("Book for 2 Nights, Pay for 1!", style: TextStyle(fontFamily: "Montserrat",  fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10,0,10,0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.gps_fixed, color: Colors.black54, size: 15,),
                                        SizedBox(width: 10,),
                                        Text("900 meters from Indra nagar MYRS station", style: TextStyle(fontFamily: "Montserrat",  fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 20,),
                          Material(
                            elevation: 5,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Offers & Deals" , style: TextStyle(fontFamily: "Montserrat",  fontSize: 18, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),
                                  Container(

                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0.1, color: Colors.black54),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: new BoxDecoration(
                                            border: Border.all(width: 1, color: Colors.blue),  //https://stackoverflow.com/a/67395539/16076689
                                            borderRadius: new BorderRadius.circular(10.0),
                                            color: Colors.white,
                                          ),
                                          child: Text(
                                            "Mobile deals",
                                            style: TextStyle(fontFamily: "Montserrat", fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text("Special discount of Rs.487 for mobile users included" , style: TextStyle(fontFamily: "Montserrat",  fontSize: 11, fontWeight: FontWeight.normal),),

                                        SizedBox(height: 20,),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: new BoxDecoration(
                                            border: Border.all(width: 1, color: Colors.blue),  //https://stackoverflow.com/a/67395539/16076689
                                            borderRadius: new BorderRadius.circular(10.0),
                                            color: Colors.white,
                                          ),
                                          child: Text(
                                            "Mobile deals",
                                            style: TextStyle(fontFamily: "Montserrat", fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text("Special discount of Rs.487 for mobile users included" , style: TextStyle(fontFamily: "Montserrat",  fontSize: 11, fontWeight: FontWeight.normal),),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 20,),
                          Material(
                            elevation: 5,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Preffered by" , style: TextStyle(fontFamily: "Montserrat",  fontSize: 18, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),

                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container( width: 80, height: 28, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.pink),),
                                            Text("Couples", style: TextStyle(fontFamily: "Montserrat", color: Colors.white))
                                          ],
                                        ),

                                        SizedBox(width: 20,),

                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container( width: 120, height: 28, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.lightBlue),),
                                            Text("Students", style: TextStyle(fontFamily: "Montserrat", color: Colors.white))
                                          ],
                                        )

                                      ],
                                    ),
                                  ),


                                  Container(

                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.1, color: Colors.black54),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: new BoxDecoration(
                                            border: Border.all(width: 1, color: Colors.blue),  //https://stackoverflow.com/a/67395539/16076689
                                            borderRadius: new BorderRadius.circular(10.0),
                                            color: Colors.white,
                                          ),
                                          child: Text(
                                            "Simplicity",
                                            style: TextStyle(fontFamily: "Montserrat", fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text("Hassle free check-in" , style: TextStyle(fontFamily: "Montserrat",  fontSize: 11, fontWeight: FontWeight.normal),),

                                        SizedBox(height: 20,),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: new BoxDecoration(
                                            border: Border.all(width: 1, color: Colors.blue),  //https://stackoverflow.com/a/67395539/16076689
                                            borderRadius: new BorderRadius.circular(10.0),
                                            color: Colors.white,
                                          ),
                                          child: Text(
                                            "Privacy",
                                            style: TextStyle(fontFamily: "Montserrat", fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text("Private booking" , style: TextStyle(fontFamily: "Montserrat",  fontSize: 11, fontWeight: FontWeight.normal),),

                                                ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    ),

                ),

              Container(
                child: Text("Articles Body"),
              ),
              Container(
                child: Text("User Body"),
              ),
              Container(
                child: Text("User Body"),
              ),
              Container(
                child: Text("User Body"),
              ),
              Container(
                child: Text("User Body"),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      appBar: AppBar(
        title: Text(
          "Details",
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        //title: Image.asset('assets/images/logo.png', width: 150, height: 30,),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 120,
            height: 30,
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: isDetailsLoading? Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(
                width: double.infinity,
                height: 200,
                child: CarouselSlider(
                  items: [
                    Image.asset(
                      "assets/images/hotel2.jpg",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/images/hotel2.jpg",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/images/hotel2.jpg",
                      fit: BoxFit.fill,
                    ),
                  ],
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                  ),
                )),

            _tabSection(context),
            



          ],
        ),
      ),

    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    //getHotelDetailsByHotelID(widget.hotelDetail['ItemID'], widget.hotelDetail['ResultIndex'], widget.hotelDetail['TraceId']);
    getHotelDetailsByHotelID('719438', '3', widget.hotelDetail['TraceId']);
    super.initState();
  }
}
