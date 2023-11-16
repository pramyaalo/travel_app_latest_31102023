import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/holidays_models.dart';
import '../holiday_detail_screen.dart';

class Holidays extends StatefulWidget {
  const Holidays({Key? key}) : super(key: key);

  @override
  _HolidaysState createState() => _HolidaysState();
}

class _HolidaysState extends State<Holidays> {
  List holidayData = [
    HolidayModel(
        title: "Alaska",
        subTitle: "516 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/0a/5d/e9/51.jpg"),
    HolidayModel(
        title: "Agra",
        subTitle: "774 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/07/3a/67/5c.jpg"),
    HolidayModel(
        title: "Singapore",
        subTitle: "630 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/09/1f/96/ad.jpg"),
    HolidayModel(
        title: "Malaysia",
        subTitle: "2986 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/06/6a/d6/93.jpg"),
    HolidayModel(
        title: "Dubai",
        subTitle: "3987 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/09/99/28/a3.jpg"),
    HolidayModel(
        title: "France",
        subTitle: "6243 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/06/fb/77/66.jpg"),
    HolidayModel(
        title: "Abu-Dhabi",
        subTitle: "399 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/0a/90/b1/ed.jpg"),
    HolidayModel(
        title: "Australia",
        subTitle: "4167 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/06/6f/02/29.jpg"),
    HolidayModel(
        title: "London",
        subTitle: "2727 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/0e/18/b9/8a.jpg"),
    HolidayModel(
        title: "Mumbai",
        subTitle: "809 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/06/6a/d2/67.jpg"),
    HolidayModel(
        title: "Italy",
        subTitle: "25892 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/06/f9/f6/a6.jpg"),
    HolidayModel(
        title: "China",
        subTitle: "11738 Tours",
        image:
            "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-240x160/0a/cd/f7/00.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
                                    "Newly Married",
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
                                    "Piligrim",
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
                                    "Tourist",
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
                              children: [
                                Image(
                                  image:
                                      AssetImage("assets/images/holiday.jpg"),
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Start holidays from",
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
                                      "change",
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
                                                HolidayDetailScreen()));
                                  },
                                  child: Text(
                                    "SEARCH HOLIDAY PACKAGES",
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
            width: double.infinity,
            height: 300,
            child: GridView(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                children: List.generate(
                    holidayData.length,
                    (index) => SizedBox(
                        width: 150,
                        height: 150,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.network(
                                  holidayData[index].image,
                                  fit: BoxFit.fill,
                                )),
                            Container(
                              color: Colors.black.withOpacity(0.5),
                              width: 150,
                              height: 40,
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Column(
                                children: [
                                  Text(
                                    holidayData[index].title,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat"),
                                  ),
                                  Text(
                                    holidayData[index].subTitle,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontFamily: "Montserrat"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )))),
          ),
        ],
      ),
    );
  }
}
