import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HolidayDetailScreen extends StatefulWidget {
  const HolidayDetailScreen({Key? key}) : super(key: key);

  @override
  _HolidayDetailScreenState createState() => _HolidayDetailScreenState();
}

class _HolidayDetailScreenState extends State<HolidayDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(

      appBar: AppBar(
        title: Text("Package details", style: TextStyle(fontFamily: "Montserrat"),),
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

      body: Column(
        children: <Widget>[
          Container(
            height: 0,
            color: Colors.blue,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                   Image(image: AssetImage("assets/images/bg1.jpg"), fit: BoxFit.contain,),

                    SizedBox(height: 10,),

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container( width: 80, height: 25, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF2f2f32)),),
                              Text("3N. 4D", style: TextStyle(fontFamily: "Montserrat", color: Colors.white))
                            ],
                          ),

                          SizedBox(width: 20,),

                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container( width: 120, height: 25, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.lightBlue),),
                              Text("EMI Available", style: TextStyle(fontFamily: "Montserrat", color: Colors.white))
                            ],
                          )

                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                        child: const Text("Country Inn & Suites by Radisson - Flight Inclusive deal", style: TextStyle(fontFamily: "Montserrat", color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),

                    Container(
                      padding: EdgeInsets.all(10),
                        child: const Text("4 Nights in Goa", style: TextStyle(fontFamily: "Montserrat", color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold))),

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("New Delhi", style: TextStyle(fontFamily: "Montserrat", color: Colors.orange, fontSize: 13, fontWeight: FontWeight.bold)),
                          Text("2 Travellers", style: TextStyle(fontFamily: "Montserrat", color: Colors.orange, fontSize: 13, fontWeight: FontWeight.bold)),
                          Text("31 JAN - 12 FEB", style: TextStyle(fontFamily: "Montserrat", color: Colors.orange, fontSize: 13, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Included in the package", style: TextStyle(fontFamily: "Montserrat", color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5,),
                          Text("You can fine-tune them to your liking", style: TextStyle(fontFamily: "Montserrat", color: Colors.black, fontSize: 13, fontWeight: FontWeight.normal)),
                          SizedBox(height: 15,),
                          Image(image: AssetImage("assets/images/holidescpng.png"))
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Exclusions", style: TextStyle(fontFamily: "Montserrat", color: Colors.blue, fontSize: 16, fontWeight: FontWeight.normal)),
                              Text(">", style: TextStyle(fontFamily: "Montserrat", color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: double.infinity,
                            height: 0.2,
                            color: Colors.grey,
                          ),

                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Terms and Conditions", style: TextStyle(fontFamily: "Montserrat", color: Colors.blue, fontSize: 16, fontWeight: FontWeight.normal)),
                              Text(">", style: TextStyle(fontFamily: "Montserrat", color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: double.infinity,
                            height: 0.2,
                            color: Colors.grey,
                          ),

                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cancellation policy", style: TextStyle(fontFamily: "Montserrat", color: Colors.blue, fontSize: 16, fontWeight: FontWeight.normal)),
                              Text(">", style: TextStyle(fontFamily: "Montserrat", color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: double.infinity,
                            height: 0.2,
                            color: Colors.grey,
                          ),

                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("After you book online", style: TextStyle(fontFamily: "Montserrat", color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal)),
                          SizedBox(height: 15,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("•", style: TextStyle(fontFamily: "Montserrat", color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                              SizedBox(width: 10,),
                              Expanded(child: Text("Instant confirmation and vouchers sent over sms, e-mail and whatsapp as soon as your booking is complete", style: TextStyle(fontFamily: "Montserrat", color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal))),
                            ],
                          ),

                          SizedBox(height: 15,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("•", style: TextStyle(fontFamily: "Montserrat", color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                              SizedBox(width: 10,),
                              Expanded(child: Text("Instant confirmation and vouchers sent over sms, e-mail and whatsapp as soon as your booking is complete", style: TextStyle(fontFamily: "Montserrat", color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal))),
                            ],
                          ),

                          SizedBox(height: 15,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("•", style: TextStyle(fontFamily: "Montserrat", color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                              SizedBox(width: 10,),
                              Expanded(child: Text("Instant confirmation and vouchers sent over sms, e-mail and whatsapp as soon as your booking is complete", style: TextStyle(fontFamily: "Montserrat", color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal))),
                            ],
                          ),


                        ],
                      ),
                    )




                  ],
                ),
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 75,
            color: Color(0xFF2f2f32),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    Text("₹14,500" , style: TextStyle(fontFamily: "Montserrat", color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("  per person" , style: TextStyle(fontFamily: "Montserrat", color: Colors.white, fontSize: 13, fontWeight: FontWeight.normal))
                  ],
                ),

                ElevatedButton(onPressed: (){

                },
                  child: Text("Book Now", style: TextStyle(fontFamily: "Montserrat"),),
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
          )

        ],
      ),
    )
    );
  }
}
