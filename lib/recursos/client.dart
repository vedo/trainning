import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trainning/modelos/LogCreateUser.dart';
import 'package:trainning/modelos/detail_product.dart';
import 'package:trainning/modelos/products.dart';
import 'package:trainning/modelos/vendors.dart';

final cliente = ClientApi();
class ClientApi{
  String host;
  String endPoint;
  Map product;
  ClientApi();
  //AUTHS
  Future<LogCreateUser> createUser({String email, String password, String username}) async {
    final storage = new FlutterSecureStorage();
    String url = "https://pancolor.cl/?rest_route=/simple-jwt-login/v1/users";
    Map<String, String> match = {
      "user_login": username,
      "email"    : email,
      "password" : password,
      "AUTH_KEY" : "2sdf6sdf8f",
    };
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    http.Response resp = await http.post(url, body: match, headers: headers);
    //parseamos la respuesta un objetoJson
    final logCreateUser = logCreateUserFromJson(resp.body);
    print(logCreateUser);
    return logCreateUser;
  }

  Future<String> _changeRol({String username, String email}) async{
    String url = "https://pancolor.cl/wp-json/wcmp/v1/vendors/";
    Map<String, String> match = {
      "login": username,
      "first_name": username,
      "last_name": "Cooper",
      "nice_name": username,
      "display_name": username,
      "email": email,
      "url": "https://algocerca.cl",
    };
    Map<String, String> headers = {
      "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvcGFuY29sb3IuY2wiLCJpYXQiOjE1OTI4NDE1ODQsIm5iZiI6MTU5Mjg0MTU4NCwiZXhwIjoxNTkzNDQ2Mzg0LCJkYXRhIjp7InVzZXIiOnsiaWQiOiIxIn19fQ.WNYq555MKC_fum5zgZL9-_BftZW0l0D10L8ZsTLfo18",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    http.Response resp = await http.post(url, body: match, headers: headers);
    print(resp.body);
    return resp.body;
  }

  Future<bool> _validToken() async{
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    http.Response resp = await http.put('https://pancolor.cl/wp-json/jwt-auth/v1/token/validate', headers: <String, String>{'Authorization': 'Bearer $token'});
    if (resp.statusCode > 200 && resp.statusCode < 300) {
      return true;
    }
    else{
      return false;
    }
    }

  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    //Si el token no es válido o no existe genero uno nuevo
    if (_validToken() == false || token == null){
      bool flag = await _getNewToken();
      if (flag == true) {
        return await storage.read(key: 'token');
      }
    }
    else{
      return await storage.read(key: 'token');
    }
  }

  Future<bool> _getNewToken() async {
  //IF BOBEDA = NULL
    final storage = new FlutterSecureStorage();
    String username = await storage.read(key: "username");
    String password = await storage.read(key: "password");
    http.Response resp = await http.get('https://pancolor.cl/wp-json/jwt-auth/v1/token',
        headers: <String, String>{'username'   : username,
                                  'password': password}
                                  );

    if (resp.statusCode > 200 && resp.statusCode < 300) {
      Map bodyJson = jsonDecode(resp.body);
      String token = bodyJson["token"];
      await storage.write(key: "token", value: token);
      return true;
    }
      else{
      return null;
      }
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
  Future<String> getResp(String endPoint) async {
    String bearerToken = 'Bearer ' + 'Aq7ltD1aMdZb';
    http.Response resp = await http.get('https://pancolor.cl/wp-json/$endPoint',
        headers: <String, String>{'authorization': bearerToken},);
    return resp.body;
    }

  Future<String> postResp(String endPoint) async{
    String bearerToken = 'Bearer ' + 'Aq7ltD1aMdZb';
    http.Response resp = await http.get('https://pancolor.cl/wp-json/$endPoint',
        headers: <String, String>{'authorization': bearerToken}, );
    return resp.body;
  }

  Future postProduct({String nameProduct, String type="simple", String regular_price, String description, int vendor}) async{
    Future<String> postResp(String endPoint) async{
      final bodyMap = jsonEncode({
        "name": "$nameProduct",
        "type": "$type",
        "regular_price": "$regular_price",
        "description": "$description",
        "short_description": "$description",
        "images": [],
        "vendor": 2});
      final mapString = bodyMap.toString();
      String bearerToken = 'Bearer ' + 'Aq7ltD1aMdZb';
      http.Response resp = await http.post('https://pancolor.cl/wp-json/$endPoint',
          headers: <String, String>{'authorization' : bearerToken,
            'Content-Type'  : 'application/json'},
          body: bodyMap);
      print(resp.body);
      return resp.body;
    }
    final product = await postResp("wc/v2/products");
    return product;
  }
  Future upload({File imageFile}) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://pancolor.cl/wp-json/wp/v2/media");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    request.headers['authorization'] =  'Bearer ' + 'Aq7ltD1aMdZb';
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
  postProductWithImage({File imagePath, String nameProduct, String type="simple", String regular_price, String description, int vendor}) async{
    //subimos la imagen
    String rawImageBody = await upload(imageFile: imagePath);
    String rawProductBody = await postProduct(nameProduct: nameProduct, type: type, regular_price: regular_price, description: description, vendor: vendor);
    Map jsonImageBody = jsonDecode(rawImageBody);
    Map jsonProductBody = jsonDecode(rawProductBody);
    print("esto es id image imagen");
    print( jsonImageBody['id']);
      print("esto es id body producto");
      print(jsonProductBody['id']);
     putImageProduct(idProduct: jsonProductBody["id"].toString(), idImage: jsonImageBody["id"].toString());
    }
    //String response = await putImageProduct(idProduct: idProduct,idImage: idImage);
   // return response;


// ESTO SUBE UN ASSET, No la he querido borrar,
// pues no sabemos si la usaremos y es bien complicado armarla nuevamante
  Future uploadImage(File image) async {
    String body;
    //al parecer cuando convierto a string el File imagen me devuelve su path
    final dbBytes = await rootBundle.load(image.toString());
    Future<File> writeToFile(ByteData data, String path) {
      final buffer = data.buffer;
      return new File(path).writeAsBytes(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes), mode: FileMode.write);
    }
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    File imageFile = await writeToFile(dbBytes, appDocDirectory.path+"/"+"temp_image.jpg");
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://pancolor.cl/wp-json/wp/v2/media");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //no es necesario esto? contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    request.headers['authorization'] =  'Bearer ' + 'Aq7ltD1aMdZb';
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value){
    });
    return response.stream.toString();
  }
  //devuelve un listado de productos por la id del vendedor; en objeto
  Future<List> getProductos(idVendor) async{
    final productos = productosFromJson(await getResp("wc/v2/products/?vendor=$idVendor"));
    return productos;
  }

  //llama el detalle del producto (id), desde la API, y devuelve los datos en un objeto
  Future getDetailProduct<map>(id) async{
    final detailProduct = detailProductFromJson(await getResp("wc/v3/products/$id"));
    return detailProduct;
  }

  //llama el listado de los vendedores, desde la API, y devuelve el dato en un objeto
  //Debe ser capaz de filtrar por ubicación a través de un parametro
  Future getVendors<map>() async{
    final vendors = vendorsFromJson(await getResp("wcmp/v1/vendors/"));
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
      String bearerToken = 'Bearer ' + 'Aq7ltD1aMdZb';
      http.Response resp = await http.put('https://pancolor.cl/wp-json/$endPoint/$idProduct',
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