import 'dart:convert';
//import 'dart:io';
import 'package:http/http.dart';
import 'package:trainning/modelos/detail_product.dart';
import 'package:trainning/modelos/products.dart';
import 'package:trainning/modelos/vendors.dart';


class ClientApi{
  String clientKey;
  String secretKey;
  String host;
  String endPoint;
  Map product;
  ClientApi({String clientKey, String secretKey, String host}){
      this.clientKey = clientKey;
      this.secretKey = secretKey;
  }

  //Este es el centro de los get a la API. Lo hace a través de oauth1 encriptado en base64encode
  Future<String> getResp(String endPoint) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$clientKey:$secretKey'));
    Response resp = await get(
      'https://pancolor.cl/wp-json/$endPoint',
      headers: <String, String>{'authorization': basicAuth}
        );
    return resp.body;
  }

  Future<String> postResp(String endPoint) async{
    final bodyMap = jsonEncode({
      "name": "Un Chacarero ají ultra fuerte",
      "type": "simple",
      "regular_price": "21010",
      "description": "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.",
      "short_description": "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
      "images": [],
      "vendor": 2
    });

    //final mapString = bodyMap.toString();

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$clientKey:$secretKey'));
    Response resp = await post(
      'https://pancolor.cl/wp-json/$endPoint',
      headers: <String, String>{
        'authorization': basicAuth,
        'Content-Type'  : 'application/json',
      },
      body: bodyMap);
      print(resp.body);
      return resp.body;
  }

  Future postProduct() async{
    final product = await postResp("wc/v2/products");
    return product;
  }

  //devuelve un listado de productos por la id del vendedor; en objeto
  Future<List> getProductos(idVendor) async{
   // final body = json.decode(await getResp("wc/v2/products/?vendor=$idVendor"));
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


}