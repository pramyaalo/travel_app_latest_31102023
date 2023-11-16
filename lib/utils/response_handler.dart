import 'dart:developer';

import 'package:http/http.dart' as http;

class ResponseHandler {
  static void tes(String dataToPrint) {
    log(dataToPrint);
  }

  static String parseData(String replyData) {
    String xmlHeader =
        "<?xml version=\"1.0\" encoding=\"utf-8\"?><string xmlns=\"http://tempuri.org/\">";
    int xmlHeaderLength = xmlHeader.length;
    return replyData.substring(xmlHeaderLength + 2).split("</string>")[0];
  }

  static Future<http.Response> performPost(String functionName, String params) {
    return http.post(
      //Uri.parse('https://gorehla.com/api/corporate.asmx/$functionName'),
      //Uri.parse('http://gorehla.d4demo.com/api/corporate.asmx/$functionName'),
      //Uri.parse('https://d4demo.com/api/corporate.asmx/$functionName'),
      Uri.parse('https://traveldemo.org/travelapp/b2c.asmx/$functionName'),
      //Uri.parse('https://api.d4demo.com/corporate.asmx/$functionName'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Access-Control-Allow-Origin': '*', // Required for CORS support to work
        'Access-Control-Allow-Headers':
            'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale',
        'Access-Control-Allow-Methods': 'POST, OPTIONS'
      },
      //body: '$params&UID=35510b94-5476-GoRehlaCorporate-a2e3-2e728ce8',
      body: '$params&UID=35510b94-5476-TDemoB2C-a2e3-2e725225',
      //body: '$params&UID=35510b94-5476-TDemoCorporate-a2e3-2e786ce8',
    );
  }
}
