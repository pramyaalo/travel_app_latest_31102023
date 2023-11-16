import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../hotel_detail_screen.dart';
import '../models/hotel_destination_models.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({Key? key}) : super(key: key);

  @override
  _HotelsScreenState createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  List hotelDestination = [
    HotelDestination(
        title: "Pondicherry",
        subtitle: "10 great deals",
        image: "https://i.ytimg.com/vi/HPY8OJDZDqc/maxresdefault.jpg"),
    HotelDestination(
        title: "Mahabalipuram",
        subtitle: "7 great deals",
        image:
            "https://www.worldhistory.org/img/r/p/500x600/4127.jpg?v=1618794907"),
    HotelDestination(
        title: "Ooty",
        subtitle: "4 great deals",
        image:
            "https://www.tourismnewslive.com/wp-content/uploads/2021/09/Mettupalayam-Ooty-train-service-.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        color: Color(0xFF152238),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                            "Domestic",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14),
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
                                            "International",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Area, Landmark or Hotel",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Chennai",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Delhi",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Date",
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
                                              "1 Night",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Rooms",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "1 Room",
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "2 Adults",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.normal),
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
                                                      fontWeight:
                                                          FontWeight.normal),
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
                                                      fontWeight:
                                                          FontWeight.normal),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        HotelDetail()));
                                          },
                                          child: Text(
                                            "SEARCH HOTELS",
                                            style: TextStyle(
                                                fontFamily: "Montserrat"),
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
                                            child:
                                                CircularProgressIndicator())),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                hotelDestination[index]
                                                    .subtitle,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                              primary: Colors.red,
                                              elevation: 16.0),
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
                  SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: CarouselSlider(
                        items: [
                          Image.asset(
                            "assets/images/six-senses-zil-payson-seychelles.webp",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "assets/images/hotel_list_2.webp",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "assets/images/bg4.jpg",
                            fit: BoxFit.cover,
                          ),
                        ],
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Travel Safely in this pandemic",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Your safety is our priority",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 250,
                          height: 150,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Card(
                            elevation: 10.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              width: 250,
                              height: 150,
                              /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://img.freepik.com/free-psd/travel-safely-banner-template_23-2149203644.jpg',
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
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 150,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Card(
                            elevation: 10.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              width: 250,
                              height: 150,
                              /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://cdn5.vectorstock.com/i/1000x1000/58/94/covid-safe-travel-logo-banner-with-passengers-vector-41645894.jpg',
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
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 150,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Card(
                            elevation: 10.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              width: 250,
                              height: 150,
                              /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://previews.123rf.com/images/decorwithme/decorwithme1903/decorwithme190300110/124429946-travel-insurance-colorful-flat-design-style-web-banner-on-white-background-with-copy-space-for.jpg',
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What's new about us?",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "We're different from others in terms of service",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          height: 250,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Card(
                            elevation: 10.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              width: 150,
                              height: 250,
                              /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://marketplace.canva.com/EAE-oK6TfmI/1/0/800w/canva-elegant-grand-opening-annoncement-invitation-banner-portrait-ZkcmPUyKFRY.jpg',
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
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 250,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Card(
                            elevation: 10.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              width: 150,
                              height: 250,
                              /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/travel-banner-design-template-74c2986da1078a325518f2202d02d74e_screen.jpg?ts=1661668122',
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
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 250,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Card(
                            elevation: 10.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              width: 150,
                              height: 250,
                              /*child: Image(
                          image: NetworkImage(hotelDestination[index].image),
                          fit: BoxFit.fill,
                        ),*/
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://marketplace.canva.com/EAEbm1h5br4/1/0/1200w/canva-blue-red-clean-%26-corporate-workplace-health-%26-safety-rules-health-explainer-poster-y07YKNJaiQ4.jpg',
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
