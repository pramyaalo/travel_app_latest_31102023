import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:marquee/marquee.dart';

import '../utils/response_handler.dart';
import 'package:http/http.dart' as http;

import 'Models/hotel_model.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({Key? key}) : super(key: key);

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  static Future<List<HotelModel>?> getHotelsList() async {
    List<HotelModel> labelData = [];
    Future<http.Response>? __futureLabels = ResponseHandler.performPost(
        "BookingHotelGet",
        "CorporateId=1001&policyID=1008&userID=1001&jsonTraveller=[{\"Name\":\"Rizwan S Mohamed - 32 (P)\",\"Id\":\"1061\"}]&CityID=107098&FromDate=2022-12-25&ToDate=2022-12-26&DefaultCurrency=SAR");

    return await __futureLabels?.then((value) {
      String jsonResponse = ResponseHandler.parseData(value.body);
      try {
        //Map<String, dynamic> map = json.decode(jsonResponse);
        //List<dynamic> list = map["Table"];
        List<dynamic> list = json.decode(jsonResponse);
        for (int i = 0; i < list.length; i++) {
          HotelModel lm = HotelModel.fromMap(list[i]);
          labelData.add(lm);
        }
      } catch (error) {
        log(error.toString());
      }
      return labelData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Hotels",
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
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<HotelModel>?>(
          future: getHotelsList(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  //return Text(snapshot.data?[index].LabelName ?? "got null");
                  return InkWell(
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10.0),
                      child: Material(
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFFFAE8FA),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFF870987),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.local_offer,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          Text(
                                            " Super Deals ",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                color: Colors.white,
                                                fontSize: 10),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Free Credits to spend at hotel",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.black87,
                                          fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 220,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            snapshot.data![index].ImageUrl,
                                        placeholder: (context, url) => Center(
                                            child: SizedBox(
                                                height: 40,
                                                width: 40,
                                                child:
                                                    CircularProgressIndicator())),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    /*Image(
                                      //image: AssetImage('assets/images/hotel_list_1.jpg'),
                                      image: NetworkImage(snapshot.data![index].ImageUrl, ),
                                      width: 120,
                                      height: 220,
                                      fit: BoxFit.cover,
                                    ),*/

                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            RatingBar.builder(
                                              initialRating: double.tryParse(
                                                  snapshot.data![index]
                                                      .StarCategory)!,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 15,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.business_center_rounded,
                                              size: 16,
                                            ),
                                            Text(
                                              snapshot
                                                  .data![index].TotalGuestCount,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  color: Colors.black87,
                                                  fontSize: 12),
                                            ),

                                            SizedBox(
                                              width: 20,
                                            ),
                                            Icon(
                                              Icons.meeting_room_sharp,
                                              size: 16,
                                            ),
                                            //Marquee(text: snapshot.data![index].RoomOffer, style: TextStyle(fontFamily: "Montserrat", color: Colors.black87, fontSize: 12 ),)
                                            SizedBox(
                                                width: 80,
                                                child: Text(
                                                  snapshot
                                                      .data![index].RoomOffer,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 12),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 200,
                                                child: Text(
                                                  snapshot
                                                      .data![index].HotelName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  const IconData(0xf053c,
                                                      fontFamily:
                                                          'MaterialIcons'),
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      snapshot
                                                          .data![index].Address,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: 45,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color(0xFF00AF80),
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data![index]
                                                          .StarCategory +
                                                      " / 5",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "487 ratings",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: 65,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color(0xFFFADEE0),
                                                  ),
                                                ),
                                                Text(
                                                  "27% Off",
                                                  style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      color: Colors.red,
                                                      fontSize: 11),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 140,
                                            ),
                                            Text(
                                              snapshot.data![index].Currency +
                                                  " " +
                                                  snapshot
                                                      .data![index].TotalPrice,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data![index].Currency +
                                                  " " +
                                                  snapshot.data![index]
                                                      .PricePerPerson,
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Text(
                                              " per person",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  color: Colors.grey,
                                                  fontSize: 13),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data![index].TravelPolicy,
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              color: Colors.red,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Free Cancellation till checkout",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              color: Color(0xFF00AF80),
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: Color(0xFFF0FFFB),
                                child: Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Image(
                                          image: AssetImage(
                                              "assets/images/handsanitizer.png"),
                                          width: 40,
                                          height: 40,
                                        )
                                      ],
                                    ),
                                    Flexible(
                                        child: Text(
                                      "Safety & Hygiene - Self certified 90% users like property restaurant",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 12),
                                    ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HotelDescription()
                          )
                      );
                    */
                    },
                  );
                },
              );
            }

            /// handles others as you did on question
            else {
              return CircularProgressIndicator();
            }
          },
        ),
      )
      /*SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(10.0),
                child: Material(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFFAE8FA),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFF870987),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.local_offer,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Text(
                                      " Super Deals ",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.white,
                                          fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Free Credits to spend at hotel",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    color: Colors.black87,
                                    fontSize: 10),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                image: AssetImage('assets/images/hotel_list_1.jpg'),
                                width: 120,
                                height: 220,
                                fit: BoxFit.cover,
                              ),

                              SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Icon(Icons.business_center_rounded, size: 16,),
                                      Text("2", style: TextStyle(fontFamily: "Montserrat", color: Colors.black87, fontSize: 12 ),),

                                      SizedBox(width: 20,),
                                      Icon(Icons.meeting_room_sharp, size: 16,),
                                      Text("34 Rooms", style: TextStyle(fontFamily: "Montserrat", color: Colors.black87, fontSize: 12 ),)
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Park Elanza", style: TextStyle(fontFamily: "Montserrat",  fontSize: 15, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Icon(const IconData(0xf053c, fontFamily: 'MaterialIcons'), size: 15,),
                                          SizedBox(width: 5,),
                                          Text("Nungambakkam", style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.normal, fontSize: 12),),
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
                                        Container(width: 45, height: 25, decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                            color: Color(0xFF00AF80),
                                        ),),
                                        Text("4.1 / 5", style: TextStyle(
                                            fontFamily: "Montserrat",
                                            color: Colors.white,
                                            fontSize: 11),)
                                      ],
                                    ),
                                    SizedBox(width: 10,),
                                    Text("487 ratings", style: TextStyle(
                                        fontFamily: "Montserrat",
                                        color: Colors.grey,
                                        fontSize: 12),),

                                    SizedBox(width: 10,),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(width: 65, height: 30, decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color(0xFFFADEE0),
                                        ),),
                                        Text("27% Off", style: TextStyle(
                                            fontFamily: "Montserrat",
                                            color: Colors.red,
                                            fontSize: 11),)
                                      ],
                                    ),

                                  ],),
                                  SizedBox(height: 10,),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 150,),
                                      Text("₹4877",  style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.grey,
                                          fontSize: 16),)
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 80,),
                                      Text("₹4877",  style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),),
                                      Text(" per night",  style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.grey,
                                          fontSize: 13),)

                                    ],
                                  ),

                                  SizedBox(height: 10,),
                                  Text("#1 in Nungambakkam",  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      color: Colors.red,
                                      fontSize: 12),),

                                  SizedBox(height: 5,),
                                  Text("Free Cancellation till checkout",  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      color: Color(0xFF00AF80),
                                      fontSize: 12),)


                                ],
                              ),


                            ],
                          ),
                        ),

                        SizedBox(height: 10,),
                        Container(
                          color: Color(0xFFF0FFFB),
                          child: Row(
                            children: [

                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height:50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,

                                    ),
                                  ),
                                  Image(image: AssetImage("assets/images/handsanitizer.png"), width: 40, height: 40,)
                                ],
                              ),

                              Flexible(child: Text("Safety & Hygiene - Self certified 90% users like property restaurant", style: TextStyle(fontFamily: "Montserrat", fontSize: 12),))

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HotelDescription()
                    )
                );

              },
            ),
          ],
        ),
      )*/
      ,
    ));
  }
}
