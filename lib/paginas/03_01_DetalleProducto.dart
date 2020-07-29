import 'dart:io';
import 'package:trainning/recursos/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:trainning/recursos/ScreenArgument.dart';
import 'package:trainning/recursos/componentes.dart';
import 'package:trainning/recursos/client.dart';
import 'package:html/parser.dart';


class DetalleProducto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenArguments args = ModalRoute.of(context).settings.arguments;
    String idProducto = args.id;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: imagenDeFondo,
          child: FutureServerCall(
            llamadaCliente: cliente.getDetailProduct( idProducto ),
            completedCallWidgetFunction: construirPaginaDetalleProducto,
          ),
        ),
      ),
    );  
  }
}


Widget construirPaginaDetalleProducto(BuildContext context, AsyncSnapshot snapshot) {
  final data = snapshot.data;
  final vendorID = data["vendor"];
  final futureVendorPhone = cliente.getVendorPhone(vendorID);
  String vendorPhone;
  futureVendorPhone.then( (value) => vendorPhone = value );
  
  return Stack(
    children: <Widget>[
      Positioned(
        top: 0, left: 0, right: 0, bottom: 0,
        child: Column(
          children: <Widget>[

            Container( // Imagen del producto
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(data["images"][0]["src"].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container( // Tarjeta de información
              color: Colors.grey[300],
              alignment: Alignment.topLeft,
              height: 150,
              child: Stack(
                children: <Widget>[
                  
                  Positioned( // Titulo y descripción
                    top: 10, left: 10, right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data["name"].toString(),
                          style: TextStyle( fontWeight: FontWeight.bold, fontSize: 22, ),
                        ),
                        SizedBox(height: 10),
                        Text(parse(data["short_description"]).body.text)
                      ],
                    )
                  ),
                  
                  Positioned( // Precio
                    left: 10, bottom: 10,
                    child: Text(
                      "\$" + data["price"].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ),
                  Positioned( //Nota
                    right: 10, bottom: 10,
                    child: Text("Nota")
                  )
              ],),
            ),

           /*  SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              height: 30,
              child: Text(
                "Comentarios:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: ListView(
                  children: <Widget>[

                    /* Acá tendría que enlistar los comentarios */
                    Container(
                      height: 100,
                      color: Colors.grey[300],
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 10, left: 10,
                            child: Text("Autor comentario"),
                          ),
                          Positioned(
                            top: 30, left: 10, right: 10,
                            child: Text("Comentario"),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),

                    SizedBox(height: 100),
                  ],
                ),
              ),
            ) */
          ],
        ),
      ),
      
      Positioned( // Contactar
        bottom: 20,
        left: 20,
        right: 20,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: gradientBlue,
          ),
          child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Text("Contactar a la persona"),
            onPressed: (){launchWhatsApp(phone: vendorPhone, message: "Hola ! Me gustaría comprar " + data["name"].toString());},
          ),
        ),
      ),

    ],
  );
} // construir

void launchWhatsApp( {@required String phone,  @required String message, }) async {
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
    } else {
      print("hola");
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    }
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    launch("tel:$phone");
  }
}