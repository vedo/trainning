import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var token;
var myId;
SharedPreferences sharedPreferences;
Servidor servidor = new Servidor();

savedCredentials() async {
  sharedPreferences = await SharedPreferences.getInstance();   
  token = sharedPreferences.getString('token');
  myId = sharedPreferences.getString('user_id');
}

class Servidor{
  String bearerToken = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYWxnb2NlcmNhLmNsIiwiaWF0IjoxNTkzNTEwMzQzLCJuYmYiOjE1OTM1MTAzNDMsImV4cCI6MTU5NDExNTE0MywiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiNCJ9fX0.S5v0PKyuQSJG0lRyw9o6t0ibeaoE3mC3N343m2ANq9o';
  //String bearerToken = 'Bearer $token';

  getVendorProducts( String vendorId ) async{
    await savedCredentials();
    var response = await http.get(
      'https://algocerca.cl/wp-json/wc/v2/products/?vendor=$vendorId',
      headers: <String, String>{'authorization': bearerToken,},
    );
    //var jsonResponse = json.decode(response.body);
    return response;
  }

  getMyProducts(){
    //return getVendorProducts(myId);  
    return getVendorProducts('2');  
  }

  getProductDetail( String productId ) async{
    await savedCredentials();
    //print('https://algocerca.cl/wp-json/wc/v2/products/$productId');
    var response = await http.get(
      'https://algocerca.cl/wp-json/wc/v2/products/$productId',
      headers: <String, String>{'authorization': bearerToken,},
    );
    return response;
  }

}