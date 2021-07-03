import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelperHotel
{
  NetworkHelperHotel({this.apiname,this.data});
  final String apiname;
  var data;
  final String baseurl = "https://ehotelmanagement.com//aruntailgirni_api/";
  Future getData() async
  {
    String url = baseurl+apiname;
    var response = await http.post(url, body: data);
    if(response.statusCode == 200)
    {
      var data = jsonDecode(response.body);
      return data;
    }
    else
    {
      print(response.statusCode);
      print("Inside Helper else: //////$data");
    }
  }
}