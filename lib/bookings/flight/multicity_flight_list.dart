import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:developer' as developer;

import '../../utils/commonutils.dart';
import '../../utils/response_handler.dart';
import 'multicity_booking.dart';

class MultiCityFlightsList extends StatefulWidget {
  const MultiCityFlightsList({super.key});

  @override
  State<MultiCityFlightsList> createState() => _MultiCityFlightsListState();
}

class _MultiCityFlightsListState extends State<MultiCityFlightsList> {

  List<dynamic> resultList = [];
  bool isLoading = false;

  Future<void> sendMultiWayFlightSearchRequest() async {
    var requestBody = {
      'OriginFirst': 'MAA', // Replace with your actual origin
      'DestinationFirst': 'DEL', // Replace with your actual destination
      'OriginSecond': 'DEL', // Replace with your actual second origin
      'DestinationSecond': 'DXB', // Replace with your actual second destination
      'DepartDateFirst': '2024/01/25', // Replace with your actual first departure date
      'DepartDateSecond': '2024/01/30', // Replace with your actual second departure date
      'OriginThird': 'DXB', // Replace with your actual third origin
      'DestinationThird': 'MAA', // Replace with your actual third destination
      'DepartDateThird': '2024/02/14', // Replace with your actual third departure date
      'OriginFourth': 'MAA', // Replace with your actual fourth origin
      'DestinationFourth': 'DEL', // Replace with your actual fourth destination
      'DepartDateFourth': '2024/02/18', // Replace with your actual fourth departure date
      'AdultCount': '1',
      'ChildrenCount': '0',
      'InfantCount': '0',
      'Class': '3',
      'DefaultCurrency': 'INR'
    };

    final url = Uri.parse('https://traveldemo.org/travelapp/corporate.asmx/AdivahaSearchFlightMultiWay');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    final body = Uri(queryParameters: requestBody).query;


    try {
      setState(() {
        isLoading = true;
      });
      var response = await http.post(
        url,
        headers: headers,
        body: requestBody,
      );

      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        var jsonData = json.decode(ResponseHandler.parseData(response.body));


        setState(() {
          resultList = List<Map<String, dynamic>>.from(jsonData);
        });

        /*developer.log(
          'Response: ${resultList}',
          name: 'ResponseLogger',
        );*/

        // Handle response here
      } else {
        print('Error ${response.statusCode} : ${response.body}');
        // Handle error here
      }
    } catch (error) {
      print('Error sending request: $error');
      // Handle error here
    }
  }

  void navigate(Widget screen){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multicity Flight", style: TextStyle(fontFamily: "Montserrat"),),
        //title: Image.asset('assets/images/logo.png', width: 150, height: 30,),
        actions: [
          Image.asset(
            'assets/images/logo.png',
            width: 120,
            height: 30,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: isLoading? Center(child: CircularProgressIndicator(),) :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Container(margin:EdgeInsets.symmetric(horizontal: 10), child: Text('Search results', style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),)),
          SizedBox(height: 10,),
          Expanded(child: ListView.builder( itemCount: resultList.length ,itemBuilder: (BuildContext context, index){
            return  InkWell(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Material(
                  elevation: 5,
                  child: Container(

                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Column(
                                        children: [
                                          ClipRRect(borderRadius: BorderRadius.circular(25),child: Image.asset('assets/images/img.png', height: 50, width: 50,)),
                                          Text(resultList[index]['CarrierNameFirst'].toString(), style: TextStyle(color: Color(0xff777777)),)
                                        ],
                                      ),

                                      Column(
                                        children: [
                                          Text('${CommonUtils.convertToFormattedTime(resultList[index]['DepartureDateFirst'].toString())} - ${CommonUtils.convertToFormattedTime(resultList[index]['ArrivalDateFirst'].toString())}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                                          Row(children: [
                                            Text(resultList[index]['DepartCityCodeFirst'].toString(), style: TextStyle(color: Color(0xff777777), fontWeight: FontWeight.bold, fontSize: 13)),
                                            Icon(Icons.arrow_right_alt),
                                            Row(
                                              children: [
                                                Text(resultList[index]['ArriveCityCodeFirst'].toString(), style: TextStyle(color: Color(0xff777777), fontWeight: FontWeight.bold, fontSize: 13)),
                                                Text(' ${resultList[index]['StopCountFirst'].toString()} stops', style: TextStyle(fontSize: 13),)
                                              ],
                                            )
                                          ],)
                                        ],
                                      ),

                                      Container()


                                    ],),
                                  ),
                                  SizedBox(height: 30,),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            ClipRRect(borderRadius: BorderRadius.circular(25),child: Image.asset('assets/images/img.png', height: 50, width: 50,)),
                                            Text(resultList[index]['CarrierNameSecond'].toString(), style: TextStyle(color: Color(0xff777777)),)
                                          ],
                                        ),

                                        Column(
                                          children: [
                                            Text('${CommonUtils.convertToFormattedTime(resultList[index]['DepartureDateSecond'].toString())} - ${CommonUtils.convertToFormattedTime(resultList[index]['ArrivalDateSecond'].toString())}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                                            Row(children: [
                                              Text(resultList[index]['DepartCityCodeSecond'].toString(), style: TextStyle(color: Color(0xff777777), fontWeight: FontWeight.bold, fontSize: 13)),
                                              Icon(Icons.arrow_right_alt),
                                              Row(
                                                children: [
                                                  Text(resultList[index]['ArriveCityCodeSecond'].toString(), style: TextStyle(color: Color(0xff777777), fontWeight: FontWeight.bold, fontSize: 13)),
                                                  Text(' ${resultList[index]['StopCountSecond'].toString()} stops', style: TextStyle(fontSize: 13),)
                                                ],
                                              )
                                            ],)
                                          ],
                                        ),

                                        Container()


                                      ],),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${resultList[index]['Currency'].toString()} ${resultList[index]['TotalPrice'].toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(resultList[index]['Refundable'].toString(), style: TextStyle(color: Color(0xff11A578 ), fontSize: 13),),
                            Text('Fare Details', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13),),
                            Text('More Details', style: TextStyle(color: Color(0xffdf7417 ), fontSize: 13),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              onTap: (){
                navigate(MultiCityBooking(flightDetail: resultList[index] ));
              },
            );
          }))
        ],
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    sendMultiWayFlightSearchRequest();
    super.initState();
  }
}
