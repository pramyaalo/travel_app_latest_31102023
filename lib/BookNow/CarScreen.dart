import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cab_list_screen.dart';
import '../models/hotel_destination_models.dart';

class CabsScreen extends StatefulWidget {
  const CabsScreen({Key? key}) : super(key: key);

  @override
  _CabsScreenState createState() => _CabsScreenState();
}

class _CabsScreenState extends State<CabsScreen> {
  List hotelDestination = [
    HotelDestination(
        title: "Travel Desk",
        subtitle: "Best CAB offers",
        image:
            "https://d168jcr2cillca.cloudfront.net/uploadimages/coupons/14522-Travelodesk_Offers_coupons.jpg"),
    HotelDestination(
        title: "100% Service guranteed",
        subtitle: "Double Back Offer",
        image:
            "https://www.gozocabs.com/blog/wp-content/uploads/2019/05/DOUBLE-BACK.png"),
    HotelDestination(
        title: "OLA rides",
        subtitle: "UPto 50% off",
        image:
            "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618490815129/ola-cabs-coupons.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                color: Colors.white,
                child: Material(
                  elevation: 5,
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffF0F5FB)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Colors
                                            .blue), //https://stackoverflow.com/a/67395539/16076689
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    "One-way",
                                    style: TextStyle(
                                        fontFamily: "Montserrat", fontSize: 14),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Colors
                                            .blue), //https://stackoverflow.com/a/67395539/16076689
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    "Round trip",
                                    style: TextStyle(
                                        fontFamily: "Montserrat", fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "From",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 13,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Nagercoil",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "NGL",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 13,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Image(
                                    width: 40,
                                    height: 40,
                                    image:
                                        AssetImage("assets/images/swap2.png")),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "To",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 13,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Tirunelvel",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "TVL",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 13,
                                          color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 0.1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pick-up",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 13,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "09 July 2022",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "07:00 PM",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 13,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Drop-off",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 13,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "11 July 2022",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "07:00 PM",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 13,
                                          color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 0.1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Filters",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: true,
                                          onChanged: (st) {},
                                        ),
                                        SizedBox(
                                          width: 0,
                                        ),
                                        Text(
                                          "Couples",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: true,
                                          onChanged: (st) {},
                                        ),
                                        SizedBox(
                                          width: 0,
                                        ),
                                        Text(
                                          "Singles",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: true,
                                          onChanged: (st) {},
                                        ),
                                        SizedBox(
                                          width: 0,
                                        ),
                                        Text(
                                          "Any",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CabsListScreen()));
                                  },
                                  child: Text(
                                    "SEARCH CABS",
                                    style: TextStyle(fontFamily: "Montserrat"),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10.0,
                                    shadowColor: Colors.orange,
                                    primary: Colors.orange,
                                    padding: EdgeInsets.all(10.0),
                                    minimumSize: Size(150, 50.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Material(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#SafeTravel",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.3, color: Colors.green),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cabs with goSafe promise",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Sanitized cabs, hand sanitizer, driver with mask and healthy status on Arogya setu app",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          Image(
                            image: AssetImage("assets/images/gosafe.png"),
                            width: 80,
                            height: 80,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 230,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  width: 330,
                  height: 200,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Card(
                    elevation: 10.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          width: 330,
                          height: 200,
                          /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                          child: CachedNetworkImage(
                            imageUrl: hotelDestination[index].image,
                            placeholder: (context, url) => Center(
                                child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                            width: 330,
                            height: 55,
                            color: Colors.black.withOpacity(0.6),
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hotelDestination[index].title,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        hotelDestination[index].subtitle,
                                        maxLines: 1,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontFamily: "Montserrat",
                                            fontSize: 13,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Explore",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red, elevation: 16.0),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              },
              itemCount: hotelDestination.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    ));
  }
}
