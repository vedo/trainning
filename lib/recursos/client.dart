import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainning/modelos/detail_product.dart';
import 'package:trainning/modelos/myproducts.dart';
import 'package:trainning/modelos/products.dart';
import 'package:trainning/modelos/profile.dart';
import 'package:trainning/modelos/vendors.dart';
import 'encripter.dart';


final cliente = ClientApi();


class ClientApi{
  Encripter rsa = new Encripter();
  String host;
  String endPoint;
  Map product;
  SharedPreferences sharedPreferences;
  ClientApi();


  //Esta es la funcion para enviar imagenes
  postProductWithImage({File imagePath, String nameProduct, String type="simple", String regular_price, String description, int vendor}) async{
    //subimos la imagen
    String rawImageBody = await upload(imageFile: imagePath);
    Map jsonImageBody = jsonDecode(rawImageBody);
    String rawProductBody = await postProduct(nameProduct: nameProduct, type: type, regular_price: regular_price, description: description, idImage: jsonImageBody["id"]);
    Map jsonProductBody = jsonDecode(rawProductBody);
    print("esto es id image imagen");
    print( jsonImageBody['src'] );
    print("esto es id body producto");
    print( jsonProductBody['id'] );
    putImageProduct(idProduct: jsonProductBody["id"].toString(), idImage: jsonImageBody["id"].toString());
  }


  Future postProduct({String nameProduct, String type="simple", String regular_price, String description, int stock, int idImage}) async{
    Future<String> postResp(String endPoint) async{
      sharedPreferences = await SharedPreferences.getInstance();
      String token = await sharedPreferences.getString("token");
      List imageList =  [{"id": idImage, "position":1}];
      String bodyMap = jsonEncode({
        "name": "$nameProduct",
        "type": "$type",
        "regular_price": "$regular_price",
        "description": "$description",
        "short_description": "$description",
        "stock_quantity": 1,
        "image_id": idImage,
      });
      final mapString = bodyMap.toString();
      String bearerToken = 'Bearer ' + token;
      http.Response resp = await http.post('http://algocerca.cl:8080/$endPoint',
          headers: <String, String>{'authorization' : bearerToken,
            'Content-Type'  : 'application/json'},
          body: bodyMap);
      print(resp.body);
      return resp.body;
    }
    final product = await postResp("upload-product");
    return product.toString();
  }


//Metodo para subir la imagen de los productos
  Future upload({File imageFile}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String token = await sharedPreferences.getString("token");
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://algocerca.cl:8080/upload-image");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    request.headers['Authorization'] =  'Bearer ' + token;
    var response = await request.send();

    // algo = response.stream.
    //print("esto es response $response");
    String body = await response.stream.bytesToString();
    //  StreamSubscription<String> body;
    //  body = response.stream.transform(utf8.decoder).listen((value)=>value.toString());
    //print("esto es body" );
    //body.onData((data) {print(data);});

    //devuelve el body del response a la api
    return body;
  }


  Future<Map> login({Map credentials}) async {    //Credentials debiera ser un mapa con username & password
    String url = "http://algocerca.cl:8080/login/";
    http.Response resp = await http.post(url, body: credentials);
    Map bodyLogin = jsonDecode(resp.body);     //Devuelve el map de la respuesta
    return bodyLogin;
  }


  /*
  testValidation: metodo 1ra etapa de la creacion de usuario,
  Está encriptado a través de la llave pública (solo cierre)
  devuelve un link con una validación de solicitud (si se accede a ese link se valida signup)
  Enviable por ejemplo al email o eventualmente implementable a través de
  Complementarlo con un sms
  */
  Future<String> testValidation({@required String name, @required String password, @required String email}) async {
    String wholeText = "$name $password $email";
    String messageEcrpt = await rsa.encripter(wholeText);
    Map<String, String> body = {
      "message": messageEcrpt, };
    String host = "http://algocerca.cl:8080/";
    String endPoint = "query/";
    http.Response resp = await http.post("$host$endPoint", body: body);
    print(resp.body);
    return resp.body;
  }


  Future getMyProfile() async{
    final myprofile = profileFromJson(await getResp(endPoint: "myprofile/", ));
    return myprofile;
  }


  Future<http.Response> confirmValidation({String url}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    http.Response resp = await http.post("$url");
    var jsonResponse = json.decode(resp.body);
    //Hacemos permanente la info del usuario para autologin y renovar tokens
    sharedPreferences.setString("token",             jsonResponse["token"]);
    return resp;
  }


  Future<bool> savePassword({@required String password}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("password", password);
    String passwordReaded = await sharedPreferences.getString("password");
    if (passwordReaded != null) {
      return true;
    }
    else {
      return false;
    }
  }


  Future<bool> genToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String username = await sharedPreferences.getString("email");
    String password = await sharedPreferences.getString("password");
    Map data = {
      'username': username,
      'password': password
    };
    if (username != null && password != null){
      var response = await http.post("https://algocerca.cl/wp-json/jwt-auth/v1/token", body: data);
      var jsonResponse = json.decode(response.body);
      if ( response.statusCode == 200 ){
        sharedPreferences.setString("token",             jsonResponse["token"]);
        return true;
        }//end: statuscode == 200
      else{
        print("error de conexion");
      }//statuscode =! 200
    }//end: if user+pass
    else{
      print("no user&passs");
      }
    //en cualquiera de los else retorna falso
    return false;
    }

  
  Future<String> changePassword({String email, String password}) async {
    http.Response resp = await http.get('');
    return resp.body;
  }


  Future<String> deleteUser({String email, String password}) async {
    http.Response resp = await http.get('');
    return resp.body;
  }


  //Este es el centro de los get a la API. Lo hace a través de oauth1 encriptado en base64encode
  Future getResp({String endPoint, String response}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String token = await sharedPreferences.getString("token");
    String bearerToken = 'Bearer ' + token;

    http.Response resp = await http.get(
      'http://algocerca.cl:8080/$endPoint',
      headers: <String, String>{'authorization': bearerToken},
    );
    if (response == "full") { //Devuelve por defecto solo el body; si queremos la respuesta completa agregamos el argumento response=full
      return resp;
    }
    else{
      return resp.body;
    }
  }


  tokenGetResp(String endPoint, String token) async {
    String bearerToken = 'Bearer ' + token;
    var resp = await http.get(
      'https://algocerca.cl/wp-json/$endPoint',
      headers: <String, String>{'authorization': bearerToken},
    );
    return resp;
  }


    //String response = await putImageProduct(idProduct: idProduct,idImage: idImage);
   // return response;
  //devuelve un listado de productos por la id del vendedor; en objeto
  Future<List> getProductos(idVendor) async{
    final productos = productosFromJson(await getResp(endPoint: "getproducts/$idVendor"));
    return productos;
  }


  Future<List> getMyProducts() async{
    final myproducts = await myproductsFromJson(await getResp(endPoint: "myproducts/", ));
    return myproducts;
  }


  //llama el detalle del producto (id), desde la API, y devuelve los datos en un objeto
  Future getDetailProduct<map>(id) async{
    final detailProduct = detailProductFromJson(await getResp(endPoint: "wc/v3/products/$id"));
    return detailProduct;
  }


  //llama el listado de los vendedores, desde la API, y devuelve el dato en un objeto
  //Debe ser capaz de filtrar por ubicación a través de un parametro
  Future getVendors<map>() async{
    final vendors = vendorsFromJson(await getResp(endPoint: "getvendors/"));
    return vendors;
  }


  /*
  ACA VAN LOS PUT!
   */
  Future<String> putResp(String endPoint) async {
    String bearerToken = 'Bearer ' + 'Aq7ltD1aMdZb';
    http.Response resp = await http.put('https://pancolor.cl/wp-json/$endPoint',
      headers: <String, String>{'authorization': bearerToken}, );
    return resp.body;
  }


  Future putImageProduct({String idProduct, String idImage}) async{
    Future<String> putResp(String endPoint) async{
      final bodyMap = jsonEncode({
        "images":[
          {
            "id": idImage,
            "position":1
          }]
      });

      final mapString = bodyMap.toString();
      print(mapString);
      String bearerToken = 'Bearer ' + 'Aq7ltD1aMdZb';
      http.Response resp = await http.put('https://algocerca.cl:8080/wp-json/$endPoint/$idProduct',
          headers: <String, String>{'authorization' : bearerToken,
            'Content-Type'  : 'application/json'},
          body: mapString);
      print(resp.body);
      return resp.body;

    }

    final product = await putResp("wc/v2/products");
    return product;

  }

}